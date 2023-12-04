import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/fullscreen_keyboard_listener.dart';

class PreviousNextNavigation extends StatelessWidget {
  const PreviousNextNavigation(
      {super.key,
      required this.onPreviousPressed,
      required this.onNextPressed,
      required this.child,
      this.maxWidth = 1000,
      this.nextBtnColor,
      this.previousBtnColor});
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final Color? nextBtnColor;
  final Color? previousBtnColor;
  final Widget child;
  final double? maxWidth;

  bool _handleKeyDown(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft && onPreviousPressed != null) {
      onPreviousPressed?.call();
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight && onNextPressed != null) {
      onNextPressed?.call();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (PlatformInfo.isMobile) return child;
    return FullscreenKeyboardListener(
      onKeyDown: _handleKeyDown,
      child: Stack(
        children: [
          child,
          Center(
            child: SizedBox(
              width: maxWidth ?? double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                child: Row(
                  children: [
                    CircleIconBtn(
                      icon: AppIcons.prev,
                      onPressed: onPreviousPressed,
                      semanticLabel: 'Previous',
                      bgColor: previousBtnColor,
                    ),
                    Spacer(),
                    CircleIconBtn(
                      icon: AppIcons.prev,
                      onPressed: onNextPressed,
                      semanticLabel: 'Next',
                      flipIcon: true,
                      bgColor: nextBtnColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
