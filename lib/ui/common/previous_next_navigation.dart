import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/fullscreen_keyboard_listener.dart';

class PreviousNextNavigation extends StatelessWidget {
  const PreviousNextNavigation({super.key, this.onPreviousPressed, this.onNextPressed, required this.child});
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final Widget child;

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
    Widget buildBtn(String semanticLabel, VoidCallback? onPressed, Alignment align, {bool isNext = false}) {
      if (PlatformInfo.isMobile) return child;
      return FullScreenKeyboardListener(
        onKeyDown: _handleKeyDown,
        child: Align(
          alignment: align,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
            child: CircleIconBtn(
              icon: AppIcons.prev,
              onPressed: onPressed,
              semanticLabel: semanticLabel,
              flipIcon: isNext,
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        child,
        //TODO-LOC: Add localization
        buildBtn('previous', onPreviousPressed, Alignment.centerLeft),
        buildBtn('next', onNextPressed, Alignment.centerRight, isNext: true),
      ],
    );
  }
}
