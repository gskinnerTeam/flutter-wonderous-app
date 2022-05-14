import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/assets.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  void _handleAboutPressed() {}

  void _handleCollectionPressed() {}

  void _handleTimelinePressed() {}

  void handleWonderPressed(WonderData data) {
    print(data);
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
                  _buildIconGrid(context),
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
      shrinkWrap: true,
      crossAxisSpacing: context.insets.sm,
      mainAxisSpacing: context.insets.sm,
      children: [
        _WonderGridBtn(data: wondersLogic.all[0], onPressed: (data) => _handleWonderPressed(context, data)),
        _WonderGridBtn(data: wondersLogic.all[1], onPressed: (_) {}),
        _WonderGridBtn(data: wondersLogic.all[2], onPressed: (_) {}),
        _WonderGridBtn(data: wondersLogic.all[3], onPressed: (_) {}),
        Padding(
          padding: EdgeInsets.all(context.insets.sm),
          child: SvgPicture.asset(SvgPaths.compassFull, color: context.colors.offWhite),
        ),
        _WonderGridBtn(data: wondersLogic.all[4], onPressed: (_) {}),
        _WonderGridBtn(data: wondersLogic.all[5], onPressed: (_) {}),
        _WonderGridBtn(data: wondersLogic.all[6], onPressed: (_) {}),
        _WonderGridBtn(data: wondersLogic.all[7], onPressed: (_) {}),
      ],
    );
  }

  Widget _buildBottomBtns(BuildContext context) {
    return SeparatedColumn(separatorBuilder: () => Divider(height: 1), children: [
      _MenuTextBtn(label: 'Explore the timeline', onPressed: _handleTimelinePressed),
      _MenuTextBtn(label: 'View your collection', onPressed: _handleCollectionPressed),
      _MenuTextBtn(label: 'About this app', onPressed: _handleAboutPressed),
    ]);
  }

  void _handleWonderPressed(BuildContext context, WonderData data) {
    Navigator.pop(context, data);
  }
}

class _WonderGridBtn extends StatelessWidget {
  const _WonderGridBtn({Key? key, required this.data, required this.onPressed}) : super(key: key);
  final WonderData data;
  final void Function(WonderData data) onPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.corners.sm),
        child: AppBtn(
          bgColor: data.type.fgColor,
          onPressed: () {},
          padding: EdgeInsets.zero,
          semanticLabel: data.title,
          children: [
            Expanded(child: Image.asset(data.type.homeBtn, fit: BoxFit.cover)),
          ],
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
      children: [Text(label, style: context.text.bodyBold)],
      padding: EdgeInsets.symmetric(vertical: context.insets.sm),
      onPressed: onPressed,
      bgColor: Colors.transparent,
      semanticLabel: label,
    );
  }
}
