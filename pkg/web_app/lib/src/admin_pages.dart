// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';

import '_dom_helper.dart';
import 'api_client/api_client.dart' deferred as api_client;
import 'page_data.dart';

final _pkgAdminWidget = _PkgAdminWidget();
final _publisherAdminWidget = _PublisherAdminWidget();
final _createPublisherWidget = _CreatePublisherWidget();
final _consentWidget = _ConsentWidget();

void initAdminPages() {
  api_client.loadLibrary().then((_) {
    _pkgAdminWidget.init();
    _createPublisherWidget.init();
    _publisherAdminWidget.init();
    _consentWidget.init();
    _initGenericForm();
  });
}

void _initGenericForm() {
  for (final form in document.querySelectorAll('[data-form-api-endpoint]')) {
    final endpoint = form.dataset['form-api-endpoint']!;

    for (final button in form.querySelectorAll('[data-form-api-button]')) {
      button.onClick.listen((event) async {
        final body = <String, Object?>{};
        for (final field in form.querySelectorAll('[name]')) {
          final name = field.attributes['name']!;
          if (field is InputElement &&
              !(field.disabled ?? false) &&
              field.value != null) {
            body[name] = field.value;
          }
          if (field is TextAreaElement &&
              !field.disabled &&
              field.value != null) {
            body[name] = field.value;
          }
        }
        await api_client.rpc(
          fn: () =>
              api_client.sendJson(verb: 'POST', path: endpoint, body: body),
          successMessage: null,
          onSuccess: (result) async {
            final message =
                result == null ? null : result['message']?.toString();
            await modalMessage('Success', text(message ?? 'OK.'));
            window.location.reload();
          },
        );
      });
    }
  }
}

/// Active on /packages/<package>/admin page.
class _PkgAdminWidget {
  Element? _setPublisherInput;
  Element? _setPublisherButton;
  InputElement? _discontinuedCheckbox;
  InputElement? _replacedByInput;
  Element? _replacedByButton;
  InputElement? _unlistedCheckbox;
  Element? _inviteUploaderButton;
  Element? _inviteUploaderContent;
  InputElement? _inviteUploaderInput;
  Element? _retractPackageVersionInput;
  Element? _retractPackageVersionButton;
  Element? _restoreRetractPackageVersionInput;
  Element? _restoreRetractPackageVersionButton;

  void init() {
    if (!pageData.isPackagePage) return;
    _setupAutomatedPublishing();
    _setPublisherInput = document.getElementById('-admin-set-publisher-input');
    _setPublisherButton =
        document.getElementById('-admin-set-publisher-button');
    _setPublisherButton?.onClick.listen((_) => _setPublisher());
    _discontinuedCheckbox = document
        .getElementById('-admin-is-discontinued-checkbox') as InputElement?;
    _discontinuedCheckbox?.onChange.listen((_) => _toogleDiscontinued());
    _replacedByInput =
        document.getElementById('-package-replaced-by') as InputElement?;
    _replacedByButton = document.getElementById('-package-replaced-by-button');
    _replacedByButton?.onClick.listen((_) => _updateReplacedBy());
    _unlistedCheckbox =
        document.getElementById('-admin-is-unlisted-checkbox') as InputElement?;
    _unlistedCheckbox?.onChange.listen((_) => _toggleUnlisted());
    _inviteUploaderButton =
        document.getElementById('-pkg-admin-invite-uploader-button');
    _inviteUploaderContent =
        document.getElementById('-pkg-admin-invite-uploader-content');
    _inviteUploaderButton?.onClick.listen((_) => _inviteUploader());
    _inviteUploaderInput = document
        .getElementById('-pkg-admin-invite-uploader-input') as InputElement?;
    _retractPackageVersionInput =
        document.getElementById('-admin-retract-package-version-input');
    _retractPackageVersionButton =
        document.getElementById('-admin-retract-package-version-button');
    _retractPackageVersionButton?.onClick.listen((_) => _setRetracted());
    _restoreRetractPackageVersionInput =
        document.getElementById('-admin-restore-retract-package-version-input');
    _restoreRetractPackageVersionButton = document
        .getElementById('-admin-restore-retract-package-version-button');
    _restoreRetractPackageVersionButton?.onClick
        .listen((_) => _restoreRetracted());
    if (_inviteUploaderContent != null) {
      _inviteUploaderContent!.remove();
      _inviteUploaderContent!.classes.remove('modal-content-hidden');
    }
    for (final btn
        in document.querySelectorAll('.-pub-remove-uploader-button')) {
      btn.onClick.listen((_) => _removeUploader(btn.dataset['email']!));
    }
  }

  void _setupAutomatedPublishing() {
    final githubEnabledCheckbox = document
        .getElementById('-pkg-admin-automated-github-enabled') as InputElement?;
    final githubRepositoryInput =
        document.getElementById('-pkg-admin-automated-github-repository')
            as InputElement?;
    final githubTagPatternInput =
        document.getElementById('-pkg-admin-automated-github-tagpattern')
            as InputElement?;
    final githubIsPushEventsCheckbox =
        document.getElementById('-pkg-admin-automated-github-push-events')
            as InputElement?;
    final githubIsWorkflowDispatchEventsCheckbox = document.getElementById(
        '-pkg-admin-automated-github-workflowdispatch-events') as InputElement?;
    final githubRequireEnvironmentCheckbox =
        document.getElementById('-pkg-admin-automated-github-requireenv')
            as InputElement?;
    final githubEnvironmentInput =
        document.getElementById('-pkg-admin-automated-github-environment')
            as InputElement?;

    final gcpEnabledCheckbox = document
        .getElementById('-pkg-admin-automated-gcp-enabled') as InputElement?;
    final gcpServiceAccountEmailInput =
        document.getElementById('-pkg-admin-automated-gcp-serviceaccountemail')
            as InputElement?;

    final updateButton = document.getElementById('-pkg-admin-automated-button');
    if (updateButton == null || githubRepositoryInput == null) {
      return;
    }
    updateButton.onClick.listen((event) async {
      await api_client.rpc<void>(
        confirmQuestion: await markdown(
            'Are you sure you want to update the automated publishing config?'),
        fn: () async {
          await api_client.client.setAutomatedPublishing(
            pageData.pkgData!.package,
            AutomatedPublishingConfig(
              github: GithubPublishingConfig(
                isEnabled: githubEnabledCheckbox!.checked ?? false,
                repository: githubRepositoryInput.value,
                tagPattern: githubTagPatternInput!.value,
                isPushEventEnabled:
                    githubIsPushEventsCheckbox!.checked ?? false,
                isWorkflowDispatchEventEnabled:
                    githubIsWorkflowDispatchEventsCheckbox!.checked ?? false,
                requireEnvironment:
                    githubRequireEnvironmentCheckbox!.checked ?? false,
                environment: githubEnvironmentInput!.value,
              ),
              gcp: GcpPublishingConfig(
                isEnabled: gcpEnabledCheckbox!.checked ?? false,
                serviceAccountEmail: gcpServiceAccountEmailInput!.value,
              ),
            ),
          );
        },
        successMessage: text('Config updated. The page will reload.'),
        onSuccess: (_) => window.location.reload(),
      );
    });
  }

  Future<void> _inviteUploader() async {
    await modalWindow(
      titleText: 'Invite new uploader',
      isQuestion: true,
      okButtonText: 'Invite',
      content: _inviteUploaderContent!,
      onExecute: () => _doInviteUploader(),
    );
  }

  Future<bool> _doInviteUploader() async {
    final email = _inviteUploaderInput!.value!.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage(
          'Input validation', text('Please specify a valid e-mail.'));
      return false;
    }

    await api_client.rpc<void>(
      fn: () async {
        await api_client.client.invitePackageUploader(
            pageData.pkgData!.package, InviteUploaderRequest(email: email));
      },
      successMessage: await markdown('`$email` was invited.'),
      onSuccess: (_) {
        _inviteUploaderInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeUploader(String email) async {
    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to remove uploader `$email` from this package?'),
      fn: () async {
        await api_client.client.removeUploaderFromUI(
          pageData.pkgData!.package,
          RemoveUploaderRequest(email: email),
        );
      },
      successMessage: await markdown(
          'Uploader `$email` removed from this package. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toogleDiscontinued() async {
    final oldValue = _discontinuedCheckbox!.defaultChecked ?? false;
    final newValue = await api_client.rpc<bool>(
      confirmQuestion: text(
          'Are you sure you want change the "discontinued" status of the package?'),
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isDiscontinued: !oldValue,
            ));
        return rs.isDiscontinued;
      },
      successMessage:
          text('"discontinued" status changed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
      onError: (err) => null,
    );
    if (newValue == null || newValue == oldValue) {
      _discontinuedCheckbox!.checked = oldValue;
    }
  }

  Future<void> _updateReplacedBy() async {
    await api_client.rpc<bool?>(
      confirmQuestion: text(
          'Are you sure you want change the "suggested replacement" field of the package?'),
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isDiscontinued: true,
              replacedBy: _replacedByInput?.value,
            ));
        return rs.isDiscontinued;
      },
      successMessage:
          text('"suggested replacement" field changed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toggleUnlisted() async {
    final oldValue = _unlistedCheckbox!.defaultChecked ?? false;
    final newValue = await api_client.rpc(
      confirmQuestion: text(
          'Are you sure you want change the "unlisted" status of the package?'),
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isUnlisted: !oldValue,
            ));
        return rs.isUnlisted;
      },
      successMessage: text('"unlisted" status changed.'),
      onError: (err) => null,
    );
    if (newValue == null) {
      _unlistedCheckbox!.checked = oldValue;
    } else {
      _unlistedCheckbox!.defaultChecked = newValue;
      _unlistedCheckbox!.checked = newValue;
    }
  }

  Future<void> _setRetracted() async {
    final version =
        materialDropdownSelected(_retractPackageVersionInput)?.trim() ?? '';
    if (version.isEmpty) {
      await _validateVersionSelection();
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to retract the package version `$version`?'),
      fn: () async {
        await api_client.client.setVersionOptions(pageData.pkgData!.package,
            version, VersionOptions(isRetracted: true));
      },
      successMessage: text('Retraction completed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _restoreRetracted() async {
    final version =
        materialDropdownSelected(_restoreRetractPackageVersionInput)?.trim() ??
            '';
    if (version.isEmpty) {
      await _validateVersionSelection();
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to restore package version `$version`?'),
      fn: () async {
        print('before setVersionOption');
        await api_client.client.setVersionOptions(pageData.pkgData!.package,
            version, VersionOptions(isRetracted: false));
      },
      successMessage: text('Restoring complete. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _validateVersionSelection() async {
    await modalMessage(
      'Input validation',
      text('Please select a version.'),
    );
  }

  Future<void> _setPublisher() async {
    final publisherId =
        materialDropdownSelected(_setPublisherInput)?.trim() ?? '';
    if (publisherId.isEmpty) {
      await modalMessage(
        'Input validation',
        text('Please specify a publisher.'),
      );
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to transfer the package to publisher `$publisherId`?'),
      fn: () async {
        final payload = PackagePublisherInfo(publisherId: publisherId);
        await api_client.client
            .setPackagePublisher(pageData.pkgData!.package, payload);
      },
      successMessage: text(
          'Transfer completed. Caches and search index will update in the next 15-20 minutes. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

/// Active on the /create-publisher page.
class _CreatePublisherWidget {
  Element? _publisherIdInput;
  Element? _createButton;

  void init() {
    _publisherIdInput = document.getElementById('-publisher-id');
    _createButton = document.getElementById('-admin-create-publisher');
    _createButton?.onClick.listen((_) {
      final publisherId =
          (_publisherIdInput as InputElement).value?.trim() ?? '';
      _triggerCreate(publisherId);
    });
  }

  void _triggerCreate(String publisherId) async {
    // Some sanity validation, server-side will enforce proper validation.
    final publisherIdPattern = RegExp(r'^([a-z0-9-]{1,63}\.)+[a-z0-9-]{1,63}$');
    if (publisherId.isEmpty || !publisherIdPattern.hasMatch(publisherId)) {
      await modalMessage(
        'Input validation',
        text('Please use a domain name as publisher identifier.'),
      );
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to create publisher for `$publisherId`?'),
      fn: () async {
        await api_client.client.createPublisher(publisherId);
      },
      successMessage: text('Publisher created. The page will reload.'),
      onSuccess: (_) {
        window.location.pathname = '/publishers/$publisherId';
      },
    );
  }
}

/// Active on the /publishers/<publisherId>/admin page.
class _PublisherAdminWidget {
  Element? _updateButton;
  TextAreaElement? _descriptionTextArea;
  InputElement? _websiteUrlInput;
  InputElement? _contactEmailInput;
  InputElement? _inviteMemberInput;
  Element? _addMemberButton;
  Element? _addMemberContent;
  String? _originalContactEmail;

  void init() {
    if (!pageData.isPublisherPage) return;
    _updateButton = document.getElementById('-publisher-update-button');
    _descriptionTextArea =
        document.getElementById('-publisher-description') as TextAreaElement?;
    _websiteUrlInput =
        document.getElementById('-publisher-website-url') as InputElement?;
    _contactEmailInput =
        document.getElementById('-publisher-contact-email') as InputElement?;
    _inviteMemberInput =
        document.getElementById('-admin-invite-member-input') as InputElement?;
    _addMemberButton = document.getElementById('-admin-add-member-button');
    _addMemberContent = document.getElementById('-admin-add-member-content');
    _originalContactEmail = _contactEmailInput?.value;
    _updateButton?.onClick.listen((_) => _updatePublisher());
    _addMemberButton?.onClick.listen((_) => _addMember());
    if (_addMemberContent != null) {
      _addMemberContent!.remove();
      _addMemberContent!.classes.remove('modal-content-hidden');
    }
    for (final btn in document.querySelectorAll('.-pub-remove-user-button')) {
      btn.onClick.listen((_) => _removeMember(
            btn.dataset['user-id']!,
            btn.dataset['email']!,
          ));
    }
  }

  Future<void> _updatePublisher() async {
    String? confirmQuestion;
    if (_originalContactEmail != _contactEmailInput!.value) {
      confirmQuestion = 'You are changing the contact email of the publisher. '
          'Changing it to an admin member email happens immediately, for other '
          'addresses we will send a confirmation request.';
    }
    await api_client.rpc<void>(
      confirmQuestion: confirmQuestion == null ? null : text(confirmQuestion),
      fn: () async {
        final payload = UpdatePublisherRequest(
          description: _descriptionTextArea!.value,
          websiteUrl: _websiteUrlInput!.value,
          contactEmail: _contactEmailInput!.value,
        );
        await api_client.client
            .updatePublisher(pageData.publisher!.publisherId, payload);
      },
      successMessage: text('Publisher was updated. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _addMember() async {
    await modalWindow(
      titleText: 'Invite new member',
      isQuestion: true,
      okButtonText: 'Add',
      content: _addMemberContent!,
      onExecute: () => _inviteMember(),
    );
  }

  Future<bool> _inviteMember() async {
    final email = _inviteMemberInput!.value!.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage(
          'Input validation', text('Please specify a valid e-mail.'));
      return false;
    }

    await api_client.rpc<void>(
      fn: () async {
        await api_client.client.invitePublisherMember(
            pageData.publisher!.publisherId, InviteMemberRequest(email: email));
      },
      successMessage: await markdown('`$email` was invited.'),
      onSuccess: (_) {
        _inviteMemberInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeMember(String userId, String email) async {
    await api_client.rpc<void>(
      confirmQuestion: await markdown(
          'Are you sure you want to remove `$email` from this publisher?'),
      fn: () async {
        await api_client.client
            .removePublisherMember(pageData.publisher!.publisherId, userId);
      },
      successMessage: await markdown(
          '`$email` removed from this publisher. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

class _ConsentWidget {
  Element? _buttons;

  void init() {
    if (!pageData.isConsentPage) return;
    _buttons = document.getElementById('-admin-consent-buttons');
    document
        .getElementById('-admin-consent-accept-button')
        ?.onClick
        .listen((_) => _accept());
    document
        .getElementById('-admin-consent-reject-button')
        ?.onClick
        .listen((_) => _reject());
  }

  void _updateButtons(bool? granted) {
    final text = granted! ? 'Consent accepted.' : 'Consent rejected.';
    _buttons!.replaceWith(Element.p()..text = text);
  }

  Future<void> _accept() async {
    await api_client.rpc(
      confirmQuestion: text('Are you sure you want to accept?'),
      fn: () async {
        final rs = await api_client.client
            .resolveConsent(pageData.consentId!, ConsentResult(granted: true));
        return rs.granted;
      },
      successMessage: text('Consent accepted.'),
      onSuccess: _updateButtons,
    );
  }

  Future<void> _reject() async {
    await api_client.rpc(
      confirmQuestion: text('Are you sure you want to reject?'),
      fn: () async {
        final rs = await api_client.client
            .resolveConsent(pageData.consentId!, ConsentResult(granted: false));
        return rs.granted;
      },
      successMessage: text('Consent rejected.'),
      onSuccess: _updateButtons,
    );
  }
}
