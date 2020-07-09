# Publishing packages

[Pub][pub-tool] isn't just for using other people's packages.
It also allows you to share your packages with the world.
If you have a useful project and you want others to be able to use it,
use the [`pub publish`][pub-publish] command.

## Publishing high quality packages

Prior to publishing, make sure to consult the general [Dart publishing
documentation](https://dart.dev/tools/pub/publishing), and all the guidelines
listed there.

Also take a look at the [pub.dev package scoring documentation](/help/scoring)
to understand how your published package will be accessed.

## Publishers

Packages can be published with either a [verified
publisher](https://dart.dev/tools/pub/verified-publishers) or with
[uploaders](https://dart.dev/tools/pub/cmd/pub-uploader). 

If are an uploader on one or more packages, you can use the **My pub.dev > My
packages** to view a list of those packages. 

If you are a member of a publisher, you can use the **My pub.dev > My
publishers** to view a list of those publishers, and under those the packages
published with those.

## Discontinuing a package

Keep in mind that publishing is forever. As soon as you publish your package,
users can depend on it. Once they start doing that, removing the package would
break theirs. To avoid that, the [pub.dev policy](https://pub.dev/policy)
disallows unpublishing packages except for very few cases.

If you are no longer maintaining a package, you can [mark it
discontinued](https://dart.dev/tools/pub/publishing#discontinue), and it will
disappear from pub.dev search.


[pub-tool]: https://dart.dev/tools/pub
[pub-publish]: https://dart.dev/tools/pub/publishing
