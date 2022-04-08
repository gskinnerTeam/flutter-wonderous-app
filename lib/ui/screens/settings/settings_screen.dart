import 'package:wonders/common_libs.dart';

class SettingsScreen extends StatelessWidget with GetItMixin {
  SettingsScreen({Key? key}) : super(key: key);

  void _handleMotionBlurToggle(v) => settings.enableMotionBlur.value = v;
  void _handleSwipeThresholdChanged(v) => settings.swipeThreshold.value = v;
  void _handleFpsToggle(v) => settings.enableFpsMeter.value = v;
  @override
  Widget build(BuildContext context) {
    final enableBlur = watchX((SettingsLogic s) => s.enableMotionBlur);
    final swipeThreshold = watchX((SettingsLogic s) => s.swipeThreshold);
    final enableFpsMeter = watchX((SettingsLogic s) => s.enableFpsMeter);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: context.textStyles.h2),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global', style: context.textStyles.h3),
            SwitchListTile(
              value: enableFpsMeter,
              onChanged: _handleFpsToggle,
              title: Text('Enable Fps Meter', style: context.textStyles.caption),
            ),
            Divider(),
            Text('Image Grid', style: context.textStyles.h3),
            SwitchListTile(
              value: enableBlur,
              onChanged: _handleMotionBlurToggle,
              title: Text('Enable Motion Blur', style: context.textStyles.caption),
            ),
            Row(
              children: [
                Gap(context.insets.sm),
                Text('Swipe Threshold (${(swipeThreshold * 100).round()})', style: context.textStyles.caption),
                Expanded(
                  child: Slider(
                    value: swipeThreshold,
                    onChanged: _handleSwipeThresholdChanged,
                    min: 0,
                    max: 1,
                    label: '',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
