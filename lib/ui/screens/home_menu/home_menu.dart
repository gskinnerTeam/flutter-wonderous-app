import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_backdrop.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/locale_switcher.dart';
import 'package:wonders/ui/common/pop_navigator_underlay.dart';
import 'package:wonders/ui/screens/home_menu/about_dialog_content.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  void _handleAboutPressed(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // ignore: use_build_context_synchronously
    if (!context.mounted) return;
    showAboutDialog(
      context: context,
      applicationName: $strings.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese: '© 2022 gskinner',
      children: [AboutDialogContent()],
      applicationIcon: Container(
        color: $styles.colors.black,
        padding: EdgeInsets.all($styles.insets.xs),
        child: Image.asset(
          ImagePaths.appLogoPlain,
          fit: BoxFit.cover,
          width: 52,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  void _handleCollectionPressed(BuildContext context) => context.push(ScreenPaths.collection(''));

  void _handleTimelinePressed(BuildContext context) => context.push(ScreenPaths.timeline(data.type));

  void _handleWonderPressed(BuildContext context, WonderData data) => Navigator.pop(context, data.type);

  @override
  Widget build(BuildContext context) {
    final double gridWidth = (context.heightPx / 2).clamp(200, 350);
    return Stack(
      children: [
        /// Backdrop / Underlay
        AppBackdrop(
          strength: .5,
          child: Container(color: $styles.colors.greyStrong.withOpacity(.7)),
        ),

        PopNavigatorUnderlay(),

        SafeArea(
          child: PaddedRow(
            padding: EdgeInsets.symmetric(
              horizontal: $styles.insets.md,
              vertical: $styles.insets.sm,
            ),
            children: [
              /// Back btn
              BackBtn.close(
                bgColor: Colors.transparent,
                iconColor: $styles.colors.offWhite,
              ),
              Spacer(),
              LocaleSwitcher()
            ],
          ),
        ),

        /// Content
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg).copyWith(top: $styles.insets.lg),
              child: Center(
                child: SizedBox(
                  width: gridWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Gap($styles.insets.md),
                      Spacer(),
                      _buildIconGrid(context)
                          .animate()
                          .fade(duration: $styles.times.fast)
                          .scale(begin: .8, curve: Curves.easeOut),
                      Gap($styles.insets.lg),
                      _buildBottomBtns(context),
                      Spacer(),
                      Gap($styles.insets.md),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
    return ValueListenableBuilder(
        valueListenable: settingsLogic.currentLocale,
        builder: (_, __, ___) {
          return SeparatedColumn(
            separatorBuilder: () => Divider(thickness: 1.5, height: 1).animate().scale(
                  duration: $styles.times.slow,
                  delay: $styles.times.pageTransition + 200.ms,
                  curve: Curves.easeOutBack,
                ),
            children: [
              _MenuTextBtn(
                  label: $strings.homeMenuButtonExplore,
                  icon: AppIcons.timeline,
                  onPressed: () => _handleTimelinePressed(context)),
              _MenuTextBtn(
                  label: $strings.homeMenuButtonView,
                  icon: AppIcons.collection,
                  onPressed: () => _handleCollectionPressed(context)),
              _MenuTextBtn(
                label: $strings.homeMenuButtonAbout,
                icon: AppIcons.info,
                onPressed: () => _handleAboutPressed(context),
              ),
            ]
                .animate(interval: 50.ms)
                .fade(delay: $styles.times.pageTransition + 50.ms)
                .slide(begin: Offset(0, .1), curve: Curves.easeOut),
          );
        });
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
  const _MenuTextBtn({Key? key, required this.label, required this.onPressed, required this.icon}) : super(key: key);
  final String label;
  final VoidCallback onPressed;
  final AppIcons icon;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      expand: true,
      padding: EdgeInsets.symmetric(vertical: $styles.insets.md),
      onPressed: onPressed,
      bgColor: Colors.transparent,
      semanticLabel: label,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(icon, color: $styles.colors.offWhite),
          Gap($styles.insets.xs),
          Text(label, style: $styles.text.bodyBold.copyWith(height: 1)),
        ],
      ),
    );
  }
}
