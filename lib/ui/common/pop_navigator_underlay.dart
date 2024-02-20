import 'package:wonders/common_libs.dart';

class PopNavigatorUnderlay extends StatelessWidget {
  const PopNavigatorUnderlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppBtn.basic(
        onPressed: () => Navigator.of(context).pop(),
        semanticLabel: '',
        child: const SizedBox.expand(),
      ),
    );
  }
}
