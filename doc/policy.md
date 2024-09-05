# pub.dev policy

## Purpose

Pub.dev facilitates sharing of Dart packages through publication.
It is central to this service that consumers of packages can trust that their
dependencies do not suddenly disappear.
Thus, once a package has been published it typically cannot be unpublished
or deleted, with the exception of the circumstances described below.
This applies to all versions of a published package.
If something has been published that is no longer relevant or maintained,
as a publisher, you can mark the package as discontinued, which will make
the package disappear from searches (but keep it available to those that
already depend on it).

Exceptions can be granted to this general policy at the pub.dev
moderators’ discretion, on email request to `support@pub.dev`.
Examples of circumstances under which exceptions may be granted include the
following:

* A package was published by mistake, and the publisher files an unpublish
  request within 48 hours.
  The pub.dev moderators will ensure that no widespread usage of the package
  has begun, and if so, may unpublish the package.
* A package violates the Naming, Content, or Copyright policies (see below).
* The package violates the [Google Terms of Service][1] or other applicable
  terms of service.

## Naming policy

Package names play an important role in the pub.dev ecosystem as they are the
identifier of a package; as a consequence package names must be unique.
When consumers wish to consume a package, they do that by referring to the
package name as this unique identifier.

Because names play such an important role, the following provisions apply
to package names:

### Name squatting

Packages may not be published solely to reserve a name for future use.
A package is considered to be engaged in "name squatting" if its code has
no objectively and genuinely useful purpose.
We do not scan pub.dev for such packages proactively, but rather rely on a
reactive, manual process where name squatting is determined by a pub.dev
moderator.
If you believe a package is engaged in name squatting, you can use the following
steps to request a pub.dev moderator review and that the package be
transferred to you:

1. Send an email requesting package transfer:
   * If the package has a publisher:
     * Locate the publisher-link in the details pane on the package page on
       pub.dev. The publisher page will have a contact email.
     * Email the publisher and copy/cc `support@pub.dev`, politely asking the
       publisher to either explain their intended purpose or transfer the
       ownership of the package to you.
   * If the package has no publisher:
     * Draft an email, politely asking the uploader to either explain their
       intended purpose or transfer the ownership of the package to you.
       Be sure to mention the package name, and your pub.dev user account.
     * Send the email to `support@pub.dev`.
       The pub.dev support team will forward the email to the package uploader.
2. If the publisher does not respond within three (3) weeks, forward the thread
   to `support@pub.dev`, and a pub.dev moderator will review your request.

### Trademark infringement

Google and pub.dev respect the importance of trademarks and other proprietary
rights, and the [Google Terms of Service][1] prohibits intellectual property
infringement.
Publishers are solely responsible for the packages and package names they use.
We take allegations of trademark infringement seriously and, as a courtesy,
we may informally investigate valid trademark complaints submitted by trademark
owners or their authorized agents (including the Attorney of Record as listed on
the trademark registration, or a representative from the headquarters of the
trademark parent company). However, we are not in a position to mediate
third party disputes, and we encourage trademark owners to resolve their
disputes directly with publishers by contacting the publisher at their email
address shown in the details pane on the package page on pub.dev.

In addition to directly contacting publishers, trademark owners or their
authorized agents who are concerned about trademark use in packages or
package names can [report][2] complaints using the "report package" link.
The complaint must include the name, role and contact information of the person
initiating the complaint, the country(ies) of trademark registration and
registration numbers (if applicable), and the URLs and package names for all
packages related to the complaint.
To ensure efficient review of your complaint, please provide all requested
information. We cannot take action on incomplete complaints.

## Content policy

Pub.dev is intended to enable developers to share Dart packages with other
developers. Thus, these packages must contain Dart source code, assets
(images, audio files, etc.) directly related to the main function of this
source code, and possibly, additional source code in other programming languages
with which the Dart code interfaces.

All content published to pub.dev must comply with the
[Google Terms of Service][1]. This includes — but is not limited to — the
following terms: Don’t abuse, harm, interfere with, or disrupt the services —
for example, by accessing or using them in fraudulent or deceptive ways,
introducing malware, or spamming, hacking, or bypassing our systems or
protective measures.

### Content moderation

We reserve the right to remove any content that doesn't follow the pub.dev
policy, including the [Google Terms of Service][1], at any time, for the reasons
provided below, and without prior notice.

Any content that violates our policies may be subject to moderation at the
discretion of the pub.dev moderators. This includes spam and deceptive content
or practices, misinformation, sensitive and/or sexually explicit content,
violent or dangerous content or practices, and content that violates the
intellectual property rights of pub.dev or others.

Pub.dev moderators conduct human reviews of all reported content.
When assessing content and making a decision to determine whether it is
inappropriate and/or violates our policies, we take various information into
consideration, such as package information
(including contents of package archives), publisher and account information
(including past history of policy violations), and other information provided
through reporting mechanisms.
Also, we take repeated violations of our policies seriously.
Repeat violations may result in more significant enforcement repercussions.

We reserve the right to take action on content that violates our policies,
as well as content that is harmful to our users and/or the overall pub.dev
ecosystem. If your account or content is found to be in violation, we may:

* Remove or limit the visibility of the material;
* Temporarily or permanently suspend your access to pub.dev;
* Report illegal materials to appropriate law enforcement authorities.

If content is removed or restricted from pub.dev, it is removed or restricted
globally by default.
Egregious violations of our policies may result in more significant enforcement
repercussions, including but not limited to an immediate ban and escalation to
law enforcement authorities.

### How to appeal a Content Moderation Decision

If you report content or an account, or your content or account was actioned
against, you will receive a notification about the type of enforcement and the
reasoning for any enforcement action. The notification will also contain a link
to submit an appeal of our decision if you believe it was a mistake.
If you submit an appeal, we’ll ask you to identify what you would like to appeal
and why. We encourage you to provide information to support your appeal.
Once we’ve reviewed your appeal, we’ll communicate the outcome to you.
If we agree with your appeal, we’ll take appropriate action to reverse our
prior decision. Appeals may not be available in all circumstances
(e.g., certain court ordered removals).
You will receive more information about your appeals options in the notification
we send to you about your content or account.

You can also find information about our appeals process by visiting our
[Help Center Article][2].

If you’re covered by the European Union’s Digital Services Act (“DSA”),
the option to refer your complaint to a certified out-of-court dispute
settlement body may also be available to you.
[Learn more about the European Union’s DSA][3].
If you have legal questions or wish to examine other remedies that may be
available to you, including the option of referring this matter to a court,
you may wish to speak to your own lawyer.

## Copyright policy

We respect the rights of copyright holders, and we do not allow packages that
are unauthorized to use copyrighted content.
Publishers are solely responsible for the packages they publish.
Copyright holders can use the "report package" link to report content for
legal reasons.

## Use of Google’s trademarks

The “Dart” name and logo and the “Flutter” name and logo are trademarks owned
by Google.
You may use the Dart and Flutter marks solely in compliance with the
[Dart brand guidelines](https://dart.dev/brand) and
[Flutter brand guidelines](https://docs.flutter.dev/brand), respectively.
For information about other Google brand features, visit
[our brand permissions site](https://www.google.com/permissions/).

## Recommendations

We display *Top packages* on the pub.dev landing page to help you find packages
for building your applications.
Top packages are selected [based on popularity][4] (including number of
downloads).
Search rankings are based on: relevance, engagement and quality.
These elements are given different importance depending on the search parameters
(such as ordering).
To estimate relevance we look into many factors, such as how well the title,
tags, description and package contents match your search query.
We estimate engagement by incorporating signals such as popularity
(based on download counts) and likes given by users.
Finally, quality is assessed through package analysis (see scoring).
These recommendations and rankings are not personalized to our users.

Recommendations and rankings are not a guarantee of quality nor suitability to
your particular situation–you should always perform your own evaluation of
packages and plugins for your project.

## Changes

Our policies may change over time. The current version of this document can be
viewed at [pub.dev/policy](https://pub.dev/policy).
To view changes refer to the [history of this document][5].


[1]: https://policies.google.com/terms?hl=en
[2]: http://pub.dev/help/content-moderation
[3]: https://support.google.com/european-union-digital-services-act-redress-options
[4]: https://pub.dev/help/scoring
[5]: https://github.com/dart-lang/pub-dev/commits/master/doc/policy.md
