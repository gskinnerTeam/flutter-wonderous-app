import 'package:flutter/material.dart';
import 'package:wonders/assets.dart';

class WonderousLogo extends StatelessWidget {
  const WonderousLogo({super.key, this.width = 100});

  final double width;

  @override
  Widget build(BuildContext context) => Image.asset(
        ImagePaths.appLogoPlain,
        fit: BoxFit.cover,
        width: width,
        filterQuality: FilterQuality.high,
      );
}
