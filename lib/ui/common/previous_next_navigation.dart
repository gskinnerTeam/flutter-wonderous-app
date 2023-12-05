import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/fullscreen_keyboard_listener.dart';

class PreviousNextNavigation extends StatefulWidget {
  const PreviousNextNavigation(
      {super.key,
      required this.onPreviousPressed,
      required this.onNextPressed,
      required this.child,
      this.maxWidth = 1000,
      this.nextBtnColor,
      this.previousBtnColor,
      this.listenToMouseWheel = true});
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final Color? nextBtnColor;
  final Color? previousBtnColor;
  final Widget child;
  final double? maxWidth;
  final bool listenToMouseWheel;

  @override
  State<PreviousNextNavigation> createState() => _PreviousNextNavigationState();
}

class _PreviousNextNavigationState extends State<PreviousNextNavigation> {
  DateTime _lastMouseScrollTime = DateTime.now();
  final int _scrollCooldownMs = 300;

  bool _handleKeyDown(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft && widget.onPreviousPressed != null) {
      widget.onPreviousPressed?.call();
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight && widget.onNextPressed != null) {
      widget.onNextPressed?.call();
      return true;
    }
    return false;
  }

  void _handleMouseScroll(event) {
    if (event is PointerScrollEvent) {
      // Cooldown, ignore scroll events that are too close together
      if (DateTime.now().millisecondsSinceEpoch - _lastMouseScrollTime.millisecondsSinceEpoch < _scrollCooldownMs) {
        return;
      }
      _lastMouseScrollTime = DateTime.now();
      if (event.scrollDelta.dy > 0 && widget.onPreviousPressed != null) {
        widget.onPreviousPressed!();
      } else if (event.scrollDelta.dy < 0 && widget.onNextPressed != null) {
        widget.onNextPressed!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (PlatformInfo.isMobile) return widget.child;
    return Listener(
      onPointerSignal: widget.listenToMouseWheel ? _handleMouseScroll : null,
      child: FullscreenKeyboardListener(
        onKeyDown: _handleKeyDown,
        child: Stack(
          children: [
            widget.child,
            Center(
              child: SizedBox(
                width: widget.maxWidth ?? double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                  child: Row(
                    children: [
                      CircleIconBtn(
                        icon: AppIcons.prev,
                        onPressed: widget.onPreviousPressed,
                        semanticLabel: 'Previous',
                        bgColor: widget.previousBtnColor,
                      ),
                      Spacer(),
                      CircleIconBtn(
                        icon: AppIcons.prev,
                        onPressed: widget.onNextPressed,
                        semanticLabel: 'Next',
                        flipIcon: true,
                        bgColor: widget.nextBtnColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
