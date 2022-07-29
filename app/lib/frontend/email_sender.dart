// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/iamcredentials/v1.dart' as iam_credentials;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:retry/retry.dart';

import '../shared/email.dart';
import '../shared/exceptions.dart';

final _logger = Logger('pub.email');

/// Sets the active [EmailSender].
void registerEmailSender(EmailSender value) =>
    ss.register(#_email_sender, value);

/// The active [EmailSender].
EmailSender get emailSender => ss.lookup(#_email_sender) as EmailSender;

// ignore: one_member_abstracts
abstract class EmailSender {
  Future<void> sendMessage(EmailMessage message);
}

EmailSender createGmailRelaySender(
  String serviceAccountEmail,
  String impersonatedGSuiteUser,
  http.Client authClient,
) =>
    _GmailSmtpRelay(
      serviceAccountEmail,
      impersonatedGSuiteUser,
      authClient,
    );

class _LoggingEmailSender implements EmailSender {
  @override
  Future<void> sendMessage(EmailMessage message) async {
    final debugHeader = '(${message.subject}) '
        'from ${message.from} '
        'to ${message.recipients.join(', ')}';

    _logger.info('Not sending email (SMTP not configured): '
        '$debugHeader\n${message.bodyText}.');
  }
}

final loggingEmailSender = _LoggingEmailSender();

Message _toMessage(EmailMessage input) {
  input.verifyUuid();
  return Message()
    ..headers = {'Message-ID': '<${input.uuid}@pub.dev>'}
    ..from = _toAddress(input.from)
    ..recipients = input.recipients.map(_toAddress).toList()
    ..subject = input.subject
    ..text = input.bodyText;
}

Address? _toAddress(EmailAddress? input) =>
    input == null ? null : Address(input.email, input.name);

/// Send emails through the gmail SMTP relay.
///
/// This sends emails through the [gmail SMTP relay][1].
/// Using the [SASL XOAUTH2][2] for authentication.
///
/// Hence, this assumes that the [gmail SMTP relay][1] has been abled by the
/// _GSuite administrator_, and that it's been configured to:
///
///  * Be authenticated by any GSuite user,
///  * Allow outgoing email from any registered GSuite user, and,
///  * Require TLS.
///
/// However, as the server is running with a _service account_, we do not
/// readily have an `access_token` with the scope `https://mail.google.com/`
/// for some GSuite user account.
///
/// To over come this, we require a [_serviceAccountEmail] which:
///
///  * The service account running this server is allowed to create tokens for.
///  * Is configured for [domain-wide delegation][3] with the
///    `https://mail.google.com/` scope on the given GSuite.
///
/// This class then creates a JWT impersonating [_impersonatedGSuiteUser] and
/// signed by [_serviceAccountEmail] (using [signJwt API][4]). It then exchanges
/// this JWT for an `access_token` using [OAuth 2 for service accounts][4].
///
/// [1]: https://support.google.com/a/answer/176600?hl=en
/// [2]: https://developers.google.com/gmail/imap/xoauth2-protocol#the_sasl_xoauth2_mechanism
/// [3]: https://developers.google.com/identity/protocols/oauth2/service-account
/// [4]: https://cloud.google.com/iam/docs/reference/credentials/rest/v1/projects.serviceAccounts/signJwt
class _GmailSmtpRelay implements EmailSender {
  static final _googleOauth2TokenUrl =
      Uri.parse('https://oauth2.googleapis.com/token');
  static const _scopes = ['https://mail.google.com/'];

  final String _serviceAccountEmail;
  final String _impersonatedGSuiteUser;
  final http.Client _authClient;

  DateTime _accessTokenRefreshed = DateTime(0);
  Future<String>? _accessToken;

  _GmailSmtpRelay(
    this._serviceAccountEmail,
    this._impersonatedGSuiteUser,
    this._authClient,
  );

  @override
  Future<void> sendMessage(EmailMessage message) async {
    final debugHeader = '(${message.subject}) '
        'from ${message.from} '
        'to ${message.recipients.join(', ')}';
    _logger.info('Sending email: $debugHeader...');
    try {
      await retry(
        () async => send(
          _toMessage(message),
          await _getSmtpServer(),
          timeout: Duration(seconds: 15),
        ),
        retryIf: (e) =>
            e is TimeoutException ||
            e is IOException ||
            e is SmtpClientCommunicationException,
        delayFactor: Duration(seconds: 2),
        maxAttempts: 2,
      );
    } on SmtpMessageValidationException catch (e, st) {
      _logger.info('Sending email failed: $debugHeader.', e, st);
      throw EmailSenderException.invalid();
    } on SmtpClientAuthenticationException catch (e, st) {
      _logger.shout('Sending email failed due to invalid auth: $e', e, st);
      throw EmailSenderException.failed();
    } on MailerException catch (e, st) {
      _logger.severe('Sending email failed: $debugHeader.', e, st);
      throw EmailSenderException.failed();
    }
  }

  Future<SmtpServer> _getSmtpServer() async {
    final maxAge = clock.now().subtract(Duration(minutes: 15));
    if (_accessToken == null || _accessTokenRefreshed.isBefore(maxAge)) {
      _accessToken = _createAccessToken();
      _accessTokenRefreshed = clock.now();
    }

    // For documentation see:
    // https://support.google.com/a/answer/176600?hl=en
    return gmailRelaySaslXoauth2(_impersonatedGSuiteUser, await _accessToken!);
  }

  /// Create an access_token for [_impersonatedGSuiteUser] using the
  /// [_serviceAccountEmail] configured for _domain-wide delegation_ following:
  /// https://developers.google.com/identity/protocols/oauth2/service-account
  Future<String> _createAccessToken() async {
    final iam = iam_credentials.IAMCredentialsApi(_authClient);
    final iat = clock.now().toUtc().millisecondsSinceEpoch ~/ 1000 - 20;
    iam_credentials.SignJwtResponse jwtResponse;
    try {
      jwtResponse = await retry(() => iam.projects.serviceAccounts.signJwt(
            iam_credentials.SignJwtRequest()
              ..payload = json.encode({
                'iss': _serviceAccountEmail,
                'scope': _scopes.join(' '),
                'aud': _googleOauth2TokenUrl.toString(),
                'exp': iat + 3600,
                'iat': iat,
                'sub': _impersonatedGSuiteUser,
              }),
            'projects/-/serviceAccounts/$_serviceAccountEmail',
          ));
    } on Exception catch (e, st) {
      _logger.severe(
        'Signing JWT for sending email failed, '
        'iam.projects.serviceAccounts.signJwt() threw',
        e,
        st,
      );
      throw SmtpClientAuthenticationException(
        'Failed to obtain signed JWT from iam.projects.serviceAccounts.signJwt',
      );
    }

    final client = http.Client();
    try {
      // Send a POST request with:
      // Content-Type: application/x-www-form-urlencoded; charset=utf-8
      return await retry(() async {
        final r = await client.post(_googleOauth2TokenUrl, body: {
          'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          'assertion': jwtResponse.signedJwt,
        });
        if (r.statusCode != 200) {
          throw SmtpClientAuthenticationException(
            'statusCode=${r.statusCode} from $_googleOauth2TokenUrl '
            'while trying exchange JWT for access_token',
          );
        }
        return json.decode(r.body)['access_token'] as String;
      });
    } finally {
      client.close();
    }
  }
}
