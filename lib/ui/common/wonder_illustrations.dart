import 'package:wonders/common_libs.dart';

class WonderIllustration extends StatelessWidget {
  const WonderIllustration(this.type, {Key? key}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WonderType.chichenItza:
        return _ChichenItzaIllustration();
      case WonderType.colosseum:
        return _ColosseumIllustration();
      case WonderType.tajMahal:
        return _TajMahalIllustration();
    }
  }
}

class _TajMahalIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Hero(tag: 'taj', child: Image.asset('assets/images/taj_mahal/taj-mahal.png')));
  }
}

class _ChichenItzaIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Hero(tag: 'chichen', child: Image.asset('assets/images/chichen_itza/pyramid.png')));
  }
}

class _ColosseumIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Hero(tag: 'colosseum', child: Image.asset('assets/images/colosseum/colosseum.png')));
  }
}
