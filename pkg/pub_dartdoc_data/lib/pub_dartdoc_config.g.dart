// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pub_dartdoc_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartdocCustomizerConfig _$DartdocCustomizerConfigFromJson(
    Map<String, dynamic> json) {
  return DartdocCustomizerConfig(
    packageName: json['packageName'] as String,
    packageVersion: json['packageVersion'] as String,
    isLatestStable: json['isLatestStable'] as bool,
    docRootUrl: json['docRootUrl'] as String,
    latestStableDocumentationUrl:
        json['latestStableDocumentationUrl'] as String,
    pubPackagePageUrl: json['pubPackagePageUrl'] as String,
    dartLogoSvgUrl: json['dartLogoSvgUrl'] as String,
    githubMarkdownCssUrl: json['githubMarkdownCssUrl'] as String,
    gtmJsUrl: json['gtmJsUrl'] as String,
    trustedTargetHosts: (json['trustedTargetHosts'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    trustedUrlSchemes: (json['trustedUrlSchemes'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$DartdocCustomizerConfigToJson(
        DartdocCustomizerConfig instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'isLatestStable': instance.isLatestStable,
      'docRootUrl': instance.docRootUrl,
      'latestStableDocumentationUrl': instance.latestStableDocumentationUrl,
      'pubPackagePageUrl': instance.pubPackagePageUrl,
      'dartLogoSvgUrl': instance.dartLogoSvgUrl,
      'githubMarkdownCssUrl': instance.githubMarkdownCssUrl,
      'gtmJsUrl': instance.gtmJsUrl,
      'trustedTargetHosts': instance.trustedTargetHosts,
      'trustedUrlSchemes': instance.trustedUrlSchemes,
    };
