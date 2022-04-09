

import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/fx/fx.dart';
import 'package:wonders/logic/data/collectible_data.dart';

class CollectibleFoundScreen extends StatelessWidget {
  final CollectibleData collectible;

  const CollectibleFoundScreen({required this.collectible, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: should this whole thing be wrapped in a RepaintBoundary?
    return FXBuilder(
      delay: 400.milliseconds,
      duration: 300.milliseconds,
      builder: (ctx, t, _) => Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(t * t * 0.5),
                Colors.black.withOpacity(t * 0.66),
              ],
              stops: [
                0,
                t*t*t*0.55,
                0.2+ t*0.7,
              ],
            )
          ),
        ),
        Center(child: Hero(tag: 'collectible', child: _buildImage(128 + 128 * t))),
      ],)
    );
  }

  Widget _buildGradient(double innerOpacity, double outerOpacity, double innerStop, double outerStop) {
    return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.black.withOpacity(innerOpacity),
                Colors.black.withOpacity(outerOpacity)
              ],
              stops: [innerStop, outerStop],
            )
          ),
        );
  }

  Widget _buildImage([double size=64.0]) {
    return Image(
      image: collectible.sillhouette,
      width: size, height: size,
      fit: BoxFit.contain,
    );
  }
}