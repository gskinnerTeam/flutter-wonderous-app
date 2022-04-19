import 'package:wonders/common_libs.dart';

class SettingsScreen extends StatelessWidget with GetItMixin {
  SettingsScreen({Key? key}) : super(key: key);

  void _handleMotionBlurToggle(v) => settingsLogic.enableMotionBlur.value = v;
  void _handleSwipeThresholdChanged(v) => settingsLogic.swipeThreshold.value = v;
  void _handleFpsToggle(v) => settingsLogic.enableFpsMeter.value = v;
  void _handleCloudsToggle(v) => settingsLogic.enableClouds.value = v;

  @override
  Widget build(BuildContext context) {
    final enableBlur = watchX((SettingsLogic s) => s.enableMotionBlur);
    final swipeThreshold = watchX((SettingsLogic s) => s.swipeThreshold);
    final enableFpsMeter = watchX((SettingsLogic s) => s.enableFpsMeter);
    final enableClouds = watchX((SettingsLogic s) => s.enableClouds);
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
            _buildRow(
              context,
              'Reset collection',
              AppTextBtn(
                'RESET',
                isSecondary: true,
                padding: EdgeInsets.all(0),
                onPressed: () => collectiblesLogic.reset(),
              ),
            ),
            Divider(),
            Text('Image Grid', style: context.textStyles.h3),
            SwitchListTile(
              value: enableBlur,
              onChanged: _handleMotionBlurToggle,
              title: Text('Enable Motion Blur', style: context.textStyles.caption),
            ),
            SwitchListTile(
              value: enableClouds,
              onChanged: _handleCloudsToggle,
              title: Text('Enable Clouds', style: context.textStyles.caption),
            ),
            _buildRow(
              context,
              'Swipe Threshold (${(swipeThreshold * 100).round()})',
              Slider(value: swipeThreshold, onChanged: _handleSwipeThresholdChanged, min: 0, max: 1, label: ''),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, Widget child) {
    return Row(
      children: [
        Gap(context.insets.sm),
        SizedBox(width: 128, child: Text(label, style: context.textStyles.caption)),
        Gap(context.insets.sm),
        Expanded(child: child),
      ],
    );
  }
}
