import 'package:wonders/common_libs.dart';

class AppLoadError extends StatelessWidget {
  const AppLoadError({Key? key, this.label}) : super(key: key);
  final String? label;
  @override
  Widget build(BuildContext context) => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) Text(label!),
          Icon(Icons.warning),
        ],
      ));
}
