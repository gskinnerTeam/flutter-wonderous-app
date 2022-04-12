import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, this.stops,
      {Key? key, this.child, this.width, this.height, this.alignment, this.begin, this.end, this.blendMode})
      : super(key: key);
  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Widget? child;
  final Alignment? begin;
  final Alignment? end;
  final Alignment? alignment;
  final BlendMode? blendMode;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          child: child,
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin ?? Alignment.centerLeft,
              end: end ?? Alignment.centerRight,
              colors: colors,
              stops: stops,
            ),
            backgroundBlendMode: blendMode,
          ),
        ),
      );
}

class HzGradient extends StatelessWidget {
  const HzGradient(this.colors, this.stops,
      {Key? key, this.child, this.width, this.height, this.alignment, this.blendMode})
      : super(key: key);
  final List<Color> colors;
  final List<double> stops;
  final Widget? child;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final BlendMode? blendMode;

  @override
  Widget build(BuildContext context) => GradientContainer(
        colors,
        stops,
        width: width,
        height: height,
        alignment: alignment,
        child: child,
        blendMode: blendMode,
      );
}

class VtGradient extends StatelessWidget {
  const VtGradient(this.colors, this.stops,
      {Key? key, this.child, this.width, this.height, this.alignment, this.blendMode})
      : super(key: key);
  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final Widget? child;
  final BlendMode? blendMode;

  @override
  Widget build(BuildContext context) => GradientContainer(
        colors,
        stops,
        width: width,
        height: height,
        alignment: alignment,
        child: child,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        blendMode: blendMode,
      );
}
