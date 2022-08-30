import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, this.stops,
      {Key? key,
      this.child,
      this.width,
      this.height,
      this.alignment,
      this.begin,
      this.end,
      this.blendMode,
      this.borderRadius})
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
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
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
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      );
}

class HzGradient extends GradientContainer {
  const HzGradient(List<Color> colors, List<double> stops,
      {Key? key,
      Widget? child,
      double? width,
      double? height,
      Alignment? alignment,
      BlendMode? blendMode,
      BorderRadius? borderRadius})
      : super(colors, stops,
            key: key,
            child: child,
            width: width,
            height: height,
            alignment: alignment,
            blendMode: blendMode,
            borderRadius: borderRadius);
}

class VtGradient extends GradientContainer {
  const VtGradient(List<Color> colors, List<double> stops,
      {Key? key,
      Widget? child,
      double? width,
      double? height,
      Alignment? alignment,
      BlendMode? blendMode,
      BorderRadius? borderRadius})
      : super(colors, stops,
            key: key,
            child: child,
            width: width,
            height: height,
            alignment: alignment,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            blendMode: blendMode,
            borderRadius: borderRadius);
}
