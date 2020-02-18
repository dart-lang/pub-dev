# pub.dev policy

## Purpose
Pub.dev facilitates the sharing via publication of Dart packages.
It is central to this service that consumers of packages can trust that their
dependencies do not suddenly disappear.
**Thus, once a package has been published it cannot be unpublished or deleted**.
This applies to all versions of a published package.
If something has been published that is no longer relevant or maintained, as a publisher,
you can mark the package as discontinued, which will make the package disappear
from searches (but keep it available to those that already depend on it).

However, because mistakes can occasionally happen, exceptions can be granted to
this general policy at the pub.dev moderators’ discretion, on email request to `support@pub.dev`.
Examples of circumstances under which exceptions may be granted include the following:

* A package was published by mistake, and the publisher files an unpublish 
  request within 48 hours. The pub.dev moderators will ensure that no widespread
  usage of the package has begun, and if so, may unpublish the package.
* A package violates the Naming, Content, or Copyright policies (see below),
  and a user files a moderation request.
* The package violates the [Google Terms of Service][google-terms]
  or other applicable terms of service.

## Naming policy
Package names play an important role in the pub.dev ecosystem as they are the identifier of a package;
as a consequence package names must be unique. When a consumer wishes to consume a package,
they do that by referring to the package name as this unique identifier.

Because names play such an important role, the following provisions apply to
package names:

### Name squatting
Packages may not be published solely to reserve a name for future use.
A package is considered to be engaged in "name squatting" if its code has no objectively and genuinely useful purpose.
We do not scan pub.dev for such packages proactively, but rather rely on a reactive,
manual process where name squatting is determined by a pub.dev moderator.
If you believe a package is engaged in name squatting,
you can use the following steps to request a pub.dev moderator review and that the package be transferred to you:

 1. Locate the email of the publisher, as shown in the details pane on the package page on pub.dev.
 2. Email the publisher and copy/cc `support@pub.dev`, politely asking the publisher to either
    explain their intended purpose or transfer the ownership of the package to you.
 3. If the publisher does not respond within three (3) weeks, forward the thread to `support@pub.dev`,
    and a pub.dev moderator will review your request.

### Trademark infringement
Google and pub.dev respect the importance of trademarks and other proprietary rights,
and the [Google Terms of Service][google-terms] prohibit intellectual property infringement.
Publishers are solely responsible for the packages and package names they use.
We take allegations of trademark infringement seriously and, as a courtesy,
we may informally investigate valid trademark complaints submitted by trademark owners
or their authorized agents (including the Attorney of Record as listed on the trademark registration,
or a representative from the headquarters of the trademark parent company).
However, we are not in a position to mediate third party disputes, and
we encourage trademark owners to resolve their disputes directly with publishers
by contacting the publisher at their email address shown in the details pane on
the package page on pub.dev. In addition to directly contacting publishers,
trademark owners or their authorized agents who are concerned about trademark
use in packages or package names can email `support@pub.dev` to submit a
complaint to the pub.dev moderators. The complaint must include the name,
role and contact information of the person initiating the complaint,
the country(ies) of trademark registration and registration numbers (if applicable),
and the URLs and package names for all packages related to the complaint.
To ensure efficient review of your complaint, please provide all requested information.
We cannot take action on incomplete complaints. We receive a high volume of
complaints and review them in the order that they are received.

See how to [report inappropriate use of a Google trademark][google-g_trademark].

## Content policy
Pub.dev is intended to enable developers to share Dart packages with other developers.
Thus, these packages are expected to contain Dart source code, assets (images, audio files, etc.)
directly related to the main function of this source code, and possibly,
additional source code in other programming languages with which the Dart code interfaces.
Any other content is not allowed on pub.dev, and may be subject to moderation at
the discretion of the pub.dev moderators, up to and including unpublishing of a package.

## Copyright policy
We respect the rights of copyright holders, and we do not allow packages or package names
that are unauthorized to use copyrighted content.
Publishers are solely responsible for the packages and package names they use.
Copyright holders can email `support@pub.dev` to submit a complaint to the pub.dev moderators.
The complaint should include the name, role and contact information of the person initiating the complaint,
a description of and link to an example of the copyrighted work,
and the URLs and package names for all packages related to the complaint.
To ensure efficient review of your complaint, please provide all requested information.
We cannot take action on incomplete complaints.
We receive a high volume of complaints and review them in the order that they are received.

## Use of Google’s trademarks
The “Dart” name and logo and the “Flutter” name and logo are trademarks owned by Google.
You may use the Dart and Flutter marks solely in compliance with the
[Dart brand guidelines][dart-brand-guidelines] and
[Flutter brand guidelines][flutter-brand-guidelines], respectively.
For information about other Google brand features,
visit [our brand permissions site][google-brand-permissions].
See how to [report inappropriate use of a Google trademark][google-g_trademark].

## Changes
Policies in this document may change over time. The current version of this
document can be viewed at [pub.dev/policy][pub-policy].
To view changes refer to the [history of this document][policy-history].

[dart-brand-guidelines]: https://dart.dev/brand
[flutter-brand-guidelines]: https://flutter.dev/brand
[google-brand-permissions]: https://www.google.com/permissions/
[google-terms]: https://policies.google.com/terms?hl=en
[google-g_trademark]: https://support.google.com/websearch/contact/g_trademark
[pub-policy]: https://pub.dev/policy
[policy-history]: https://github.com/dart-lang/pub-dev/commits/master/doc/policy.md
