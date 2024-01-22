import 'package:home_widget/home_widget.dart';
import 'package:wonders/logic/common/platform_info.dart';

/// Small facade for the HomeWidget package
class NativeWidgetService {
  static const _iosAppGroupId = 'group.com.gskinner.flutter.wonders.widget';
  static const _iosAppName = 'WonderousWidget';

  final bool isSupported = PlatformInfo.isIOS;

  Future<void> init() async {
    if (!isSupported) return;
    await HomeWidget.setAppGroupId(_iosAppGroupId);
  }

  Future<bool?> save<T>(String s, T value, {void Function(bool?)? onSaveComplete}) async {
    if (!isSupported) return false;
    return await HomeWidget.saveWidgetData<T>(s, value).then((value) {
      onSaveComplete?.call(value);
      return null;
    });
  }

  Future<bool?> markDirty() async {
    if (!isSupported) return false;
    return await HomeWidget.updateWidget(iOSName: _iosAppName);
  }
}
