import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';

class AppShortcuts {
  static final Map<ShortcutActivator, Intent> _defaultWebAndDesktopShortcuts = <ShortcutActivator, Intent>{
    // Activation
    if (kIsWeb) ...{
      // On the web, enter activates buttons, but not other controls.
      SingleActivator(LogicalKeyboardKey.enter): ButtonActivateIntent(),
      SingleActivator(LogicalKeyboardKey.numpadEnter): ButtonActivateIntent(),
    } else ...{
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.gameButtonA): ActivateIntent(),
    },

    // Dismissal
    SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),

    // Keyboard traversal.
    SingleActivator(LogicalKeyboardKey.tab): NextFocusIntent(),
    SingleActivator(LogicalKeyboardKey.tab, shift: true): PreviousFocusIntent(),

    // Scrolling
    SingleActivator(LogicalKeyboardKey.arrowUp): ScrollIntent(direction: AxisDirection.up),
    SingleActivator(LogicalKeyboardKey.arrowDown): ScrollIntent(direction: AxisDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowLeft): ScrollIntent(direction: AxisDirection.left),
    SingleActivator(LogicalKeyboardKey.arrowRight): ScrollIntent(direction: AxisDirection.right),
    SingleActivator(LogicalKeyboardKey.pageUp):
        ScrollIntent(direction: AxisDirection.up, type: ScrollIncrementType.page),
    SingleActivator(LogicalKeyboardKey.pageDown):
        ScrollIntent(direction: AxisDirection.down, type: ScrollIncrementType.page),
  };

  static Map<ShortcutActivator, Intent>? get defaults {
    switch (defaultTargetPlatform) {
      // fall back to default shortcuts for ios and android
      case TargetPlatform.iOS:
      case TargetPlatform.android:
        return null;
      // unify shortcuts for desktop/web
      default:
        return _defaultWebAndDesktopShortcuts;
    }
  }
}
