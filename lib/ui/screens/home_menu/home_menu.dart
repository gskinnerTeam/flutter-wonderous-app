import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  void _handleAboutPressed() {}

  void _handleCollectionPressed(BuildContext context) => context.push(
        ScreenPaths.collection(''),
      );

  void _handleTimelinePressed(BuildContext context) => context.push(ScreenPaths.timeline(data.type));

  void _handleWonderPressed(BuildContext context, WonderData data) {
    Navigator.pop(context, data.type);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Blur filter
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: context.colors.greyStrong.withOpacity(.5),
          ),
        ),

        /// Back btn
        BackBtn.close(
          bgColor: Colors.transparent,
          iconColor: context.colors.offWhite,
        ).safe(),

        /// Content
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(flex: 3),
                  _buildIconGrid(context)
                      .fx()
                      .fade(duration: context.times.fast * 1.5)
                      .scale(begin: .8, curve: Curves.easeOut),
                  Spacer(flex: 2),
                  _buildBottomBtns(context),
                  Gap(context.insets.xl),
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
      crossAxisSpacing: context.insets.sm,
      mainAxisSpacing: context.insets.sm,
      children: [
        _buildGridBtn(context, wondersLogic.all[0]),
        _buildGridBtn(context, wondersLogic.all[1]),
        _buildGridBtn(context, wondersLogic.all[2]),
        _buildGridBtn(context, wondersLogic.all[3]),
        Padding(
          padding: EdgeInsets.all(context.insets.sm),
          child: SvgPicture.asset(SvgPaths.compassFull, color: context.colors.offWhite),
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
      separatorBuilder: () => Divider(thickness: 1.5, height: 1).fx().scale(
            duration: context.times.slow,
            delay: context.times.pageTransition + 200.ms,
            curve: Curves.easeOutBack,
          ),
      children: [
        _MenuTextBtn(label: 'Explore the timeline', onPressed: () => _handleTimelinePressed(context)),
        _MenuTextBtn(label: 'View your collection', onPressed: () => _handleCollectionPressed(context)),
        _MenuTextBtn(label: 'About this app', onPressed: _handleAboutPressed),
      ]
          .fx(interval: 80.ms)
          .fade(delay: context.times.pageTransition + 100.ms)
          .slide(begin: Offset(0, .1), curve: Curves.easeOut),
    );
  }

  Widget _buildGridBtn(BuildContext context, WonderData btnData) {
    bool isSelected = btnData == data;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.corners.md),
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
          borderRadius: BorderRadius.circular(context.corners.md),
          child: AppBtn(
            border: !isSelected ? null : BorderSide(color: context.colors.offWhite, width: 5),
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
      child: Text(label, style: context.text.bodyBold),
      padding: EdgeInsets.symmetric(vertical: context.insets.sm),
      onPressed: onPressed,
      bgColor: Colors.transparent,
      semanticLabel: label,
    );
  }
}
