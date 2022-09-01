import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/modals/fullscreen_web_view.dart';

class AboutDialogContent extends StatelessWidget {
  const AboutDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleTap(String url) => Navigator.push(context, CupertinoPageRoute(builder: (_) => FullscreenWebView(url)));

    List<TextSpan> buildSpan(String text, {Map<String, List<String>>? linkSupplants}) {
      if (linkSupplants?.isNotEmpty ?? false) {
        final r = RegExp(r'\{\w+\}');
        final matches = r.allMatches(text);
        final a = text.split(r);

        final supplantKeys = matches.map((x) => x.group(0));
        final sortedEntries = supplantKeys.map((x) => linkSupplants?.entries.firstWhere((e) => e.key == x));

        final spans = <TextSpan>[];
        for (var i = 0; i < a.length; i++) {
          spans.add(TextSpan(text: a[i]));
          if (i < sortedEntries.length) {
            final label = sortedEntries.elementAt(i)!.value[0];
            final link = sortedEntries.elementAt(i)!.value[1];
            spans.add(TextSpan(
              text: label,
              recognizer: TapGestureRecognizer()..onTap = () => handleTap(link),
              style: TextStyle(fontWeight: FontWeight.bold, color: $styles.colors.accent1),
            ));
          }
        }
        return spans;
      } else {
        return [TextSpan(text: text)];
      }
    }

    return SingleChildScrollView(
      child: Column(children: [
        Gap($styles.insets.sm),
        RichText(
          text: TextSpan(
            style: $styles.text.bodySmall.copyWith(color: Colors.black),
            children: [
              ...buildSpan($strings.homeMenuAboutWonderous),
              ...buildSpan($strings.homeMenuAboutBuilt, linkSupplants: {
                '{flutterUrl}': [$strings.homeMenuAboutFlutter, 'https://flutter.dev'],
                '{gskinnerUrl}': [$strings.homeMenuAboutGskinner, 'https://gskinner.com/flutter'],
              }),
              ...buildSpan('\n\n'),
              ...buildSpan($strings.homeMenuAboutLearn, linkSupplants: {
                '{wonderousUrl}': [$strings.homeMenuAboutApp, 'https://wonderous.app'],
              }),
              ...buildSpan('\n\n'),
              ...buildSpan($strings.homeMenuAboutSource, linkSupplants: {
                '{githubUrl}': [$strings.homeMenuAboutRepo, 'https://github.com/gskinnerTeam/flutter-wonderous-app'],
              }),
              ...buildSpan('\n\n'),
              ...buildSpan($strings.homeMenuAboutPublic, linkSupplants: {
                '{metUrl}': [
                  $strings.homeMenuAboutMet,
                  'https://www.metmuseum.org/about-the-met/policies-and-documents/open-access'
                ],
              }),
              ...buildSpan('\n\n'),
              ...buildSpan($strings.homeMenuAboutPhotography, linkSupplants: {
                '{unsplashUrl}': [$strings.homeMenuAboutUnsplash, 'https://unsplash.com/@gskinner/collections'],
              }),
            ],
          ),
        ),
      ]),
    );
  }
}
