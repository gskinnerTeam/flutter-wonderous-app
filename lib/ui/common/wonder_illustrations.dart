import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {Key? key}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WonderType.machuPicchu:
        return _MachuPicchuIllustration();
      case WonderType.petra:
        return _PetraIllustration();
    }
  }
}

class _MachuPicchuIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Hero(tag: 'matchu', child: FlutterLogo(size: 500)));
  }
}

class _PetraIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Hero(tag: 'petra', child: FlutterLogo(size: 500)));
  }
}
