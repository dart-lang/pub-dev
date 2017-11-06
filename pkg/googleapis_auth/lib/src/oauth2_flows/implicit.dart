// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.implicit_gapi_flow;

import "dart:async";
import 'dart:html' as html;
import "dart:js" as js;

import '../../auth.dart';
import '../utils.dart';

// This will be overridden by tests.
String GapiUrl = 'https://apis.google.com/js/client.js';

/// This class performs the implicit browser-based oauth2 flow.
///
/// It has to be used in two steps:
///
/// 1. First call initialize() and wait until the Future completes successfully
///    - loads the 'gapi' JavaScript library into the current document
///    - wait until the library signals it is ready
///
/// 2. Call login() as often as needed.
///    - will call the 'gapi' JavaScript lib to trigger an oauth2 browser flow
///      => This might create a popup which asks the user for consent.
///    - will wait until the flow is completed (successfully or not)
///      => Completes with AccessToken or an Exception.
/// 3. Call loginHybrid() as often as needed.
///    - will call the 'gapi' JavaScript lib to trigger an oauth2 browser flow
///      => This might create a popup which asks the user for consent.
///    - will wait until the flow is completed (successfully or not)
///      => Completes with a tuple [AccessCredentials cred, String authCode]
///         or an Exception.
class ImplicitFlow {
  static const CallbackTimeout = const Duration(seconds: 20);

  final String _clientId;
  final List<String> _scopes;

  ImplicitFlow(this._clientId, this._scopes);

  Future initialize() {
    var completer = new Completer();

    var timeout = new Timer(CallbackTimeout, () {
      completer.completeError(new Exception(
          'Timed out while waiting for the gapi.auth library to load.'));
    });

    js.context['dartGapiLoaded'] = () {
      timeout.cancel();
      try {
        var gapi = js.context['gapi']['auth'];
        gapi.callMethod('init', [
          () {
            completer.complete();
          }
        ]);
      } catch (error, stack) {
        completer.completeError(error, stack);
      }
    };

    var script = new html.ScriptElement();
    script.src = '${GapiUrl}?onload=dartGapiLoaded';
    script.onError.first.then((errorEvent) {
      timeout.cancel();
      completer.completeError(new Exception('Failed to load gapi library.'));
    });
    html.document.body.append(script);

    return completer.future;
  }

  Future loginHybrid({bool force: false, bool immediate: false}) {
    return _login(force, immediate, true);
  }

  Future<AccessCredentials> login({bool force: false, bool immediate: false}) {
    return _login(force, immediate, false);
  }

  // Completes with either credentials or a tuple of credentials and authCode.
  //  hybrid  =>  [AccessCredentials credentials, String authCode]
  // !hybrid  =>  AccessCredentials
  Future _login(bool force, bool immediate, bool hybrid) {
    var completer = new Completer();

    var gapi = js.context['gapi']['auth'];

    var json = {
      'client_id': _clientId,
      'immediate': immediate,
      'approval_prompt': force ? 'force' : 'auto',
      'response_type': hybrid ? 'code token' : 'token',
      'scope': _scopes.join(' '),
      'access_type': hybrid ? 'offline' : 'online',
    };

    gapi.callMethod('authorize', [
      new js.JsObject.jsify(json),
      (jsTokenObject) {
        var tokenType = jsTokenObject['token_type'];
        var token = jsTokenObject['access_token'];
        var expiresInRaw = jsTokenObject['expires_in'];
        var code = jsTokenObject['code'];
        var error = jsTokenObject['error'];

        var expiresIn;
        if (expiresInRaw is String) {
          expiresIn = int.parse(expiresInRaw);
        }

        if (error != null) {
          completer.completeError(
              new UserConsentException('Failed to get user consent: $error.'));
        } else if (token == null ||
            expiresIn is! int ||
            tokenType != 'Bearer') {
          completer.completeError(new Exception(
              'Failed to obtain user consent. Invalid server response.'));
        } else {
          var accessToken =
              new AccessToken('Bearer', token, expiryDate(expiresIn));
          var credentials = new AccessCredentials(accessToken, null, _scopes);

          if (hybrid) {
            if (code == null) {
              completer.completeError(new Exception('Expected to get auth code '
                  'from server in hybrid flow, but did not.'));
            }
            completer.complete([credentials, code]);
          } else {
            completer.complete(credentials);
          }
        }
      }
    ]);

    return completer.future;
  }
}
