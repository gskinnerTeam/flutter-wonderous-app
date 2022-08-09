import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/modals/fullscreen_web_view.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  void _handleAboutPressed(BuildContext context) {
    void handleTap(String url) => Navigator.push(context, CupertinoPageRoute(builder: (_) => FullscreenWebView(url)));

    List<TextSpan> _buildSpan(String text, {Map<String, List<String>>? linkSupplants}) {
      if (linkSupplants?.isNotEmpty ?? false) {
        final r = RegExp(r'\{\w+\}');
        final matches = r.allMatches(text);
        final a = text.split(r);

        final supplantKeys = matches.map((x) => x.group(0));
        final sortedEntries = supplantKeys.map((x) => linkSupplants?.entries.firstWhere((e) => e.key == x));

        List<TextSpan> t = [];
        for (var i = 0; i < a.length; i++) {
          t.add(TextSpan(text: a[i]));
          if (i < sortedEntries.length) {
            final label = sortedEntries.elementAt(i)!.value[0];
            final link = sortedEntries.elementAt(i)!.value[1];
            t.add(TextSpan(
              text: label,
              recognizer: TapGestureRecognizer()..onTap = () => handleTap(link),
              style: TextStyle(fontWeight: FontWeight.bold, color: $styles.colors.accent1),
            ));
          }
        }
        return t;
      } else {
        return [TextSpan(text: text)];
      }
    }

    showAboutDialog(
      context: context,
      applicationName: $strings.appName,
      applicationVersion: '1.1.1',
      applicationLegalese: '© 2022 gskinner',
      children: [
        Gap($styles.insets.sm),
        RichText(
          text: TextSpan(
            style: $styles.text.body.copyWith(color: Colors.black),
            children: [
              ..._buildSpan($strings.homeMenuAboutWonderous),
              ..._buildSpan($strings.homeMenuAboutBuilt, linkSupplants: {
                '{flutterUrl}': [$strings.homeMenuAboutFlutter, 'https://flutter.dev'],
                '{gskinnerUrl}': [$strings.homeMenuAboutGskinner, 'https://gskinner.com/flutter'],
              }),
              ..._buildSpan('\n\n'),
              ..._buildSpan($strings.homeMenuAboutLearn, linkSupplants: {
                '{wonderousUrl}': [$strings.homeMenuAboutApp, 'https://wonderous.app'],
              }),
              ..._buildSpan('\n\n'),
              ..._buildSpan($strings.homeMenuAboutSource, linkSupplants: {
                '{githubUrl}': [$strings.homeMenuAboutRepo, 'https://github.com/gskinnerTeam/flutter-wonders-app'],
              }),
            ],
          ),
        ),
      ],
      applicationIcon: Image.asset(ImagePaths.appIcon, fit: BoxFit.cover, width: 64),
    );
  }

  void _handleCollectionPressed(BuildContext context) => context.push(ScreenPaths.collection(''));

  void _handleTimelinePressed(BuildContext context) => context.push(ScreenPaths.timeline(data.type));

  void _handleWonderPressed(BuildContext context, WonderData data) => Navigator.pop(context, data.type);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Blur filter
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: $styles.colors.greyStrong.withOpacity(.5),
          ),
        ),

        /// Back btn
        BackBtn.close(
          bgColor: Colors.transparent,
          iconColor: $styles.colors.offWhite,
        ).safe(),

        /// Content
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(flex: 3),
                  _buildIconGrid(context)
                      .animate()
                      .fade(duration: $styles.times.fast * 1.5)
                      .scale(begin: .8, curve: Curves.easeOut),
                  Spacer(flex: 2),
                  _buildBottomBtns(context),
                  Gap($styles.insets.xl),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIconGrid(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      clipBehavior: Clip.none,
      shrinkWrap: true,
      crossAxisSpacing: $styles.insets.sm,
      mainAxisSpacing: $styles.insets.sm,
      children: [
        _buildGridBtn(context, wondersLogic.all[0]),
        _buildGridBtn(context, wondersLogic.all[1]),
        _buildGridBtn(context, wondersLogic.all[2]),
        _buildGridBtn(context, wondersLogic.all[3]),
        Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: SvgPicture.asset(SvgPaths.compassFull, color: $styles.colors.offWhite),
        ),
        _buildGridBtn(context, wondersLogic.all[4]),
        _buildGridBtn(context, wondersLogic.all[5]),
        _buildGridBtn(context, wondersLogic.all[6]),
        _buildGridBtn(context, wondersLogic.all[7]),
      ],
    );
  }

  Widget _buildBottomBtns(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => Divider(thickness: 1.5, height: 1).animate().scale(
            duration: $styles.times.slow,
            delay: $styles.times.pageTransition + 200.ms,
            curve: Curves.easeOutBack,
          ),
      children: [
        _MenuTextBtn(label: $strings.homeMenuButtonExplore, onPressed: () => _handleTimelinePressed(context)),
        _MenuTextBtn(label: $strings.homeMenuButtonView, onPressed: () => _handleCollectionPressed(context)),
        _MenuTextBtn(label: $strings.homeMenuButtonAbout, onPressed: () => _handleAboutPressed(context)),
      ]
          .animate(interval: 80.ms)
          .fade(delay: $styles.times.pageTransition + 100.ms)
          .slide(begin: Offset(0, .1), curve: Curves.easeOut),
    );
  }

  Widget _buildGridBtn(BuildContext context, WonderData btnData) {
    bool isSelected = btnData == data;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular($styles.corners.md),
          boxShadow: !isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 3,
                    spreadRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular($styles.corners.md),
          child: AppBtn(
            border: !isSelected ? null : BorderSide(color: $styles.colors.offWhite, width: 5),
            bgColor: btnData.type.fgColor,
            onPressed: () => _handleWonderPressed(context, btnData),
            padding: EdgeInsets.zero,
            semanticLabel: btnData.title,
            child: SizedBox.expand(child: Image.asset(btnData.type.homeBtn, fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}

class _MenuTextBtn extends StatelessWidget {
  const _MenuTextBtn({Key? key, required this.label, required this.onPressed}) : super(key: key);
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      expand: true,
      padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
      onPressed: onPressed,
      bgColor: Colors.transparent,
      semanticLabel: label,
      child: Text(label, style: $styles.text.bodyBold.copyWith(height: 1)),
    );
  }
}
