// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:web/web.dart';

import '_dom_helper.dart';
import 'api_client/api_client.dart' deferred as api_client;
import 'page_data.dart';
import 'web_util.dart';

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
  for (final form
      in document
          .querySelectorAll('[data-form-api-endpoint]')
          .toElementList<HTMLElement>()) {
    final endpoint = form.dataset['form-api-endpoint'];
    final onSuccessGotoUrl = form.getAttribute('data-form-success-goto');

    for (final button
        in form.querySelectorAll('[data-form-api-button]').toElementList()) {
      button.onClick.listen((event) async {
        final body = <String, Object?>{};
        for (final field in form.querySelectorAll('[name]').toElementList()) {
          final name = field.getAttribute('name')!;
          if (field is HTMLInputElement && !field.disabled) {
            body[name] = field.value;
          }
          if (field is HTMLTextAreaElement && !field.disabled) {
            body[name] = field.value;
          }
        }
        await api_client.rpc(
          fn: () =>
              api_client.sendJson(verb: 'POST', path: endpoint, body: body),
          successMessage: null,
          onSuccess: (r) async {
            final result = r ?? {};
            // Goto a new location to display the feedback message.
            if (onSuccessGotoUrl != null) {
              window.location.href = onSuccessGotoUrl;
              return;
            }

            // We shall display a minimal feedback the message is omitted.
            final message =
                result['message']?.toString() ??
                'Success. The page will reload.';
            await modalMessage('Success', message);

            window.location.reload();
          },
        );
      });
    }
  }
}

/// Active on `/packages/<package>/admin` page.
class _PkgAdminWidget {
  Element? _setPublisherInput;
  Element? _setPublisherButton;
  HTMLInputElement? _discontinuedCheckbox;
  HTMLInputElement? _replacedByInput;
  Element? _replacedByButton;
  HTMLInputElement? _unlistedCheckbox;
  Element? _inviteUploaderButton;
  Element? _inviteUploaderContent;
  HTMLInputElement? _inviteUploaderInput;
  Element? _retractPackageVersionInput;
  Element? _retractPackageVersionButton;
  Element? _restoreRetractPackageVersionInput;
  Element? _restoreRetractPackageVersionButton;

  void init() {
    if (!pageData.isPackagePage) return;
    _setupAutomatedPublishing();
    _setPublisherInput = document.getElementById('-admin-set-publisher-input');
    _setPublisherButton = document.getElementById(
      '-admin-set-publisher-button',
    );
    _setPublisherButton?.onClick.listen((_) => _setPublisher());
    _discontinuedCheckbox =
        document.getElementById('-admin-is-discontinued-checkbox')
            as HTMLInputElement?;
    _discontinuedCheckbox?.onChange.listen((_) => _toggleDiscontinued());
    _replacedByInput =
        document.getElementById('-package-replaced-by') as HTMLInputElement?;
    _replacedByButton = document.getElementById('-package-replaced-by-button');
    _replacedByButton?.onClick.listen((_) => _updateReplacedBy());
    _unlistedCheckbox =
        document.getElementById('-admin-is-unlisted-checkbox')
            as HTMLInputElement?;
    _unlistedCheckbox?.onChange.listen((_) => _toggleUnlisted());
    _inviteUploaderButton = document.getElementById(
      '-pkg-admin-invite-uploader-button',
    );
    _inviteUploaderContent = document.getElementById(
      '-pkg-admin-invite-uploader-content',
    );
    _inviteUploaderButton?.onClick.listen((_) => _inviteUploader());
    _inviteUploaderInput =
        document.getElementById('-pkg-admin-invite-uploader-input')
            as HTMLInputElement?;
    _retractPackageVersionInput = document.getElementById(
      '-admin-retract-package-version-input',
    );
    _retractPackageVersionButton = document.getElementById(
      '-admin-retract-package-version-button',
    );
    _retractPackageVersionButton?.onClick.listen((_) => _setRetracted());
    _restoreRetractPackageVersionInput = document.getElementById(
      '-admin-restore-retract-package-version-input',
    );
    _restoreRetractPackageVersionButton = document.getElementById(
      '-admin-restore-retract-package-version-button',
    );
    _restoreRetractPackageVersionButton?.onClick.listen(
      (_) => _restoreRetracted(),
    );
    _inviteUploaderContent
      ?..classList.remove('modal-content-hidden')
      ..remove();
    for (final btn
        in document
            .querySelectorAll('.-pub-remove-uploader-button')
            .toElementList<HTMLElement>()) {
      btn.onClick.listen((_) => _removeUploader(btn.dataset['email']));
    }
  }

  void _setupAutomatedPublishing() {
    final manualPublishingEnabledCheckbox =
        document.getElementById('-pkg-admin-manual-publishing-enabled')
            as HTMLInputElement?;
    final githubEnabledCheckbox =
        document.getElementById('-pkg-admin-automated-github-enabled')
            as HTMLInputElement?;
    final githubRepositoryInput =
        document.getElementById('-pkg-admin-automated-github-repository')
            as HTMLInputElement?;
    final githubTagPatternInput =
        document.getElementById('-pkg-admin-automated-github-tagpattern')
            as HTMLInputElement?;
    final githubIsPushEventsCheckbox =
        document.getElementById('-pkg-admin-automated-github-push-events')
            as HTMLInputElement?;
    final githubIsWorkflowDispatchEventsCheckbox =
        document.getElementById(
              '-pkg-admin-automated-github-workflowdispatch-events',
            )
            as HTMLInputElement?;
    final githubRequireEnvironmentCheckbox =
        document.getElementById('-pkg-admin-automated-github-requireenv')
            as HTMLInputElement?;
    final githubEnvironmentInput =
        document.getElementById('-pkg-admin-automated-github-environment')
            as HTMLInputElement?;

    final gcpEnabledCheckbox =
        document.getElementById('-pkg-admin-automated-gcp-enabled')
            as HTMLInputElement?;
    final gcpServiceAccountEmailInput =
        document.getElementById('-pkg-admin-automated-gcp-serviceaccountemail')
            as HTMLInputElement?;

    final updateButton = document.getElementById('-pkg-admin-automated-button');
    if (updateButton == null || githubRepositoryInput == null) {
      return;
    }
    updateButton.onClick.listen((event) async {
      await api_client.rpc<void>(
        confirmQuestion:
            'Are you sure you want to update the publishing config?',
        fn: () async {
          await api_client.client.setAutomatedPublishing(
            pageData.pkgData!.package,
            PkgPublishingConfig(
              github: GitHubPublishingConfig(
                isEnabled: githubEnabledCheckbox!.checked,
                repository: githubRepositoryInput.value,
                tagPattern: githubTagPatternInput!.value,
                isPushEventEnabled: githubIsPushEventsCheckbox!.checked,
                isWorkflowDispatchEventEnabled:
                    githubIsWorkflowDispatchEventsCheckbox!.checked,
                requireEnvironment: githubRequireEnvironmentCheckbox!.checked,
                environment: githubEnvironmentInput!.value,
              ),
              gcp: GcpPublishingConfig(
                isEnabled: gcpEnabledCheckbox!.checked,
                serviceAccountEmail: gcpServiceAccountEmailInput!.value,
              ),
              manual: ManualPublishingConfig(
                isEnabled: manualPublishingEnabledCheckbox?.checked ?? true,
              ),
            ),
          );
        },
        successMessage: 'Config updated. The page will reload.',
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
      onExecute: _doInviteUploader,
    );
  }

  Future<bool> _doInviteUploader() async {
    final email = _inviteUploaderInput!.value.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage('Input validation', 'Please specify a valid e-mail.');
      return false;
    }

    await api_client.rpc<void>(
      fn: () async {
        await api_client.client.invitePackageUploader(
          pageData.pkgData!.package,
          InviteUploaderRequest(email: email),
        );
      },
      successMessage: '`$email` was invited.',
      onSuccess: (_) {
        _inviteUploaderInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeUploader(String email) async {
    await api_client.rpc<void>(
      confirmQuestion:
          'Are you sure you want to remove uploader `$email` from this package?',
      fn: () async {
        await api_client.client.removeUploaderFromUI(
          pageData.pkgData!.package,
          RemoveUploaderRequest(email: email),
        );
      },
      successMessage:
          'Uploader `$email` removed from this package. The page will reload.',
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toggleDiscontinued() async {
    final oldValue = _discontinuedCheckbox!.defaultChecked;
    final newValue = await api_client.rpc<bool>(
      confirmQuestion:
          'Are you sure you want change the "discontinued" status of the package?',
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
          pageData.pkgData!.package,
          PkgOptions(isDiscontinued: !oldValue),
        );
        return rs.isDiscontinued;
      },
      successMessage: '"discontinued" status changed. The page will reload.',
      onSuccess: (_) => window.location.reload(),
      onError: (err) => null,
    );
    if (newValue == null || newValue == oldValue) {
      _discontinuedCheckbox!.checked = oldValue;
    }
  }

  Future<void> _updateReplacedBy() async {
    await api_client.rpc<bool?>(
      confirmQuestion:
          'Are you sure you want change the "suggested replacement" field of the package?',
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
          pageData.pkgData!.package,
          PkgOptions(isDiscontinued: true, replacedBy: _replacedByInput?.value),
        );
        return rs.isDiscontinued;
      },
      successMessage:
          '"suggested replacement" field changed. The page will reload.',
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toggleUnlisted() async {
    final oldValue = _unlistedCheckbox!.defaultChecked;
    final newValue = await api_client.rpc(
      confirmQuestion:
          'Are you sure you want change the "unlisted" status of the package?',
      fn: () async {
        final rs = await api_client.client.setPackageOptions(
          pageData.pkgData!.package,
          PkgOptions(isUnlisted: !oldValue),
        );
        return rs.isUnlisted;
      },
      successMessage: '"unlisted" status changed.',
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
      confirmQuestion:
          'Are you sure you want to retract the package version `$version`?',
      fn: () async {
        await api_client.client.setVersionOptions(
          pageData.pkgData!.package,
          version,
          VersionOptions(isRetracted: true),
        );
      },
      successMessage: 'Retraction completed. The page will reload.',
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
      confirmQuestion:
          'Are you sure you want to restore package version `$version`?',
      fn: () async {
        print('before setVersionOption');
        await api_client.client.setVersionOptions(
          pageData.pkgData!.package,
          version,
          VersionOptions(isRetracted: false),
        );
      },
      successMessage: 'Restoring complete. The page will reload.',
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _validateVersionSelection() async {
    await modalMessage('Input validation', 'Please select a version.');
  }

  Future<void> _setPublisher() async {
    final publisherId =
        materialDropdownSelected(_setPublisherInput)?.trim() ?? '';
    if (publisherId.isEmpty) {
      await modalMessage('Input validation', 'Please specify a publisher.');
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion:
          'Are you sure you want to transfer the package to publisher `$publisherId`?',
      fn: () async {
        final payload = PackagePublisherInfo(publisherId: publisherId);
        await api_client.client.setPackagePublisher(
          pageData.pkgData!.package,
          payload,
        );
      },
      successMessage:
          'Transfer completed. Caches and search index will update in the next 15-20 minutes. The page will reload.',
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
      final publisherId = (_publisherIdInput as HTMLInputElement).value.trim();
      _triggerCreate(publisherId);
    });
  }

  void _triggerCreate(String publisherId) async {
    // Some sanity validation, server-side will enforce proper validation.
    final publisherIdPattern = RegExp(r'^([a-z0-9-]{1,63}\.)+[a-z0-9-]{1,63}$');
    if (publisherId.isEmpty || !publisherIdPattern.hasMatch(publisherId)) {
      await modalMessage(
        'Input validation',
        'Please use a domain name as publisher identifier.',
      );
      return;
    }

    await api_client.rpc<void>(
      confirmQuestion:
          'Are you sure you want to create publisher for `$publisherId`?',
      fn: () async {
        await api_client.client.createPublisher(publisherId);
      },
      successMessage:
          'Publisher created. You can now transfer packages to this publisher. '
          'The page will reload.',
      onSuccess: (_) {
        window.location.pathname = '/publishers/$publisherId/admin';
      },
    );
  }
}

/// Active on the `/publishers/<publisherId>/admin` page.
class _PublisherAdminWidget {
  Element? _updateButton;
  HTMLTextAreaElement? _descriptionTextArea;
  HTMLInputElement? _websiteUrlInput;
  HTMLInputElement? _contactEmailInput;
  HTMLInputElement? _inviteMemberInput;
  Element? _addMemberButton;
  Element? _addMemberContent;
  String? _originalContactEmail;

  void init() {
    if (!pageData.isPublisherPage) return;
    _updateButton = document.getElementById('-publisher-update-button');
    _descriptionTextArea =
        document.getElementById('-publisher-description')
            as HTMLTextAreaElement?;
    _websiteUrlInput =
        document.getElementById('-publisher-website-url') as HTMLInputElement?;
    _contactEmailInput =
        document.getElementById('-publisher-contact-email')
            as HTMLInputElement?;
    _inviteMemberInput =
        document.getElementById('-admin-invite-member-input')
            as HTMLInputElement?;
    _addMemberButton = document.getElementById('-admin-add-member-button');
    _addMemberContent = document.getElementById('-admin-add-member-content');
    _originalContactEmail = _contactEmailInput?.value;
    _updateButton?.onClick.listen((_) => _updatePublisher());
    _addMemberButton?.onClick.listen((_) => _addMember());
    if (_addMemberContent != null) {
      _addMemberContent!.remove();
      _addMemberContent!.classList.remove('modal-content-hidden');
    }
    for (final btn
        in document
            .querySelectorAll('.-pub-remove-user-button')
            .toElementList<HTMLElement>()) {
      btn.onClick.listen(
        (_) => _removeMember(btn.dataset['user-id'], btn.dataset['email']),
      );
    }
  }

  Future<void> _updatePublisher() async {
    String? confirmQuestion;
    if (_originalContactEmail != _contactEmailInput!.value) {
      confirmQuestion =
          'You are changing the contact email of the publisher. '
          'Changing it to an admin member email happens immediately, for other '
          'addresses we will send a confirmation request.';
    }
    await api_client.rpc<void>(
      confirmQuestion: confirmQuestion,
      fn: () async {
        final payload = UpdatePublisherRequest(
          description: _descriptionTextArea!.value,
          websiteUrl: _websiteUrlInput!.value,
          contactEmail: _contactEmailInput!.value,
        );
        await api_client.client.updatePublisher(
          pageData.publisher!.publisherId,
          payload,
        );
      },
      successMessage: 'Publisher was updated. The page will reload.',
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _addMember() async {
    await modalWindow(
      titleText: 'Invite new member',
      isQuestion: true,
      okButtonText: 'Add',
      content: _addMemberContent!,
      onExecute: _inviteMember,
    );
  }

  Future<bool> _inviteMember() async {
    final email = _inviteMemberInput!.value.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage('Input validation', 'Please specify a valid e-mail.');
      return false;
    }

    await api_client.rpc<void>(
      fn: () async {
        await api_client.client.invitePublisherMember(
          pageData.publisher!.publisherId,
          InviteMemberRequest(email: email),
        );
      },
      successMessage: '`$email` was invited.',
      onSuccess: (_) {
        _inviteMemberInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeMember(String userId, String email) async {
    await api_client.rpc<void>(
      confirmQuestion:
          'Are you sure you want to remove `$email` from this publisher?',
      fn: () async {
        await api_client.client.removePublisherMember(
          pageData.publisher!.publisherId,
          userId,
        );
      },
      successMessage:
          '`$email` removed from this publisher. The page will reload.',
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
    _buttons!.replaceWith(HTMLParagraphElement()..textContent = text);
  }

  Future<void> _accept() async {
    await api_client.rpc(
      confirmQuestion: 'Are you sure you want to accept?',
      fn: () async {
        final rs = await api_client.client.resolveConsent(
          pageData.consentId!,
          ConsentResult(granted: true),
        );
        return rs.granted;
      },
      successMessage: 'Consent accepted.',
      onSuccess: _updateButtons,
    );
  }

  Future<void> _reject() async {
    await api_client.rpc(
      confirmQuestion: 'Are you sure you want to reject?',
      fn: () async {
        final rs = await api_client.client.resolveConsent(
          pageData.consentId!,
          ConsentResult(granted: false),
        );
        return rs.granted;
      },
      successMessage: 'Consent rejected.',
      onSuccess: _updateButtons,
    );
  }
}
