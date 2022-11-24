import 'package:wonders/common_libs.dart';

/// Combines [Align], [FractionalBoxWithMinSize], [Image] and [Transform.translate]
/// to standardize behavior across the various wonder illustrations
class IllustrationPiece extends StatelessWidget {
  const IllustrationPiece({
    Key? key,
    required this.type,
    required this.anim,
    required this.fileName,
    required this.heightFactor,
    this.alignment = Alignment.center,
    this.minHeight,
    this.translation,
  }) : super(key: key);

  final WonderType type;
  final Animation<double> anim;
  final double heightFactor;
  final String fileName;
  final Offset? translation;
  final Alignment alignment;
  final double? minHeight;
  final BoxFit boxFit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: translation ?? Offset.zero,
        child: FractionalBoxWithMinSize(
          heightFactor: heightFactor,
          minHeight: minHeight ?? 0,
          child: Image.asset('${type.assetPath}/$fileName', opacity: anim, fit: boxFit),
        ),
      ),
    );
  }
}
//
// class IllustrationPieceStack extends StatelessWidget {
//   const IllustrationPieceStack({Key? key, required this.pieces}) : super(key: key);
//   final List<IllustrationPiece> pieces;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: pieces,
//       // [
//       //   BottomCenter(
//       //     child: Transform.translate(
//       //       offset: Offset(context.widthPx * .05, 0),
//       //       child: FractionalBoxWithMinSize(
//       //         heightFactor: backHeightFactor,
//       //         minHeight: 300,
//       //         child: Image.asset(
//       //           '${type.assetPath}/foreground-back.png',
//       //           opacity: anim,
//       //           fit: BoxFit.cover,
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       //   BottomCenter(
//       //     child: Transform.translate(
//       //       offset: Offset(-context.widthPx * .1, 0),
//       //       child: FractionalBoxWithMinSize(
//       //         heightFactor: frontHeightFactor,
//       //         minHeight: 300,
//       //         child: Image.asset(
//       //           '${type.assetPath}/foreground-front.png',
//       //           opacity: anim,
//       //           fit: BoxFit.cover,
//       //         ),
//       //       ),
//       //     ),
//       //   )
//
//       // BottomCenter(
//       //   child: Transform.scale(
//       //     scale: 1 + config.zoom * .05,
//       //     child: FractionallySizedBox(
//       //       heightFactor: backHeightFactor,
//       //       child: FractionalTranslation(
//       //           translation: Offset(.1, 0),
//       //           child: Image.asset('${type.assetPath}/foreground-back.png', opacity: anim, fit: BoxFit.cover)),
//       //     ),
//       //   ),
//       // ),
//       // BottomCenter(
//       //   child: Transform.scale(
//       //     scale: 1 + config.zoom * .2,
//       //     child: FractionallySizedBox(
//       //       heightFactor: frontHeightFactor,
//       //       child: FractionalTranslation(
//       //           translation: Offset(-.2, 0),
//       //           child: Image.asset('${type.assetPath}/foreground-front.png', opacity: anim, fit: BoxFit.cover)),
//       //     ),
//       //   ),
//       // ),
//       // ],
//     );
//   }
// }

/// Encapsulates a common behavior where
/// - we want something to be fractionally sized, down to a pt...
/// - when we hit a minSize, stop reducing in size...
/// - until available space is less < minSize, then allow piece to reduce
/// eg, Take a piece with 50% height, and 500px minHeight. As available height is reduced it will attempt to use 50% height,
/// At 200px it  it will stop reducing itself in height and ignore the fractional sizing.
/// One the available height is < 200px, the piece will then reduce itself so it still
/// fits on screen without being clipped.
class FractionalBoxWithMinSize extends StatelessWidget {
  const FractionalBoxWithMinSize(
      {Key? key, this.minWidth, this.minHeight, this.widthFactor, this.heightFactor, required this.child})
      : super(key: key);

  final double? widthFactor;
  final double? heightFactor;
  final double? minWidth;
  final double? minHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert((widthFactor == null && minWidth == null) || (widthFactor != null && minWidth != null),
        'widthFactor and minWidth must be provided together');
    assert((heightFactor == null && minHeight == null) || (heightFactor != null && minHeight != null),
        'heightFactor and minWidth must be provided together');
    return LayoutBuilder(builder: (context, constraints) {
      var c = child;
      if (widthFactor != null) {
        double size = max(minWidth!, widthFactor! * constraints.maxWidth);
        c = SizedBox(width: size, child: c);
      }
      if (heightFactor != null) {
        double size = max(minHeight!, heightFactor! * constraints.maxHeight);
        c = SizedBox(height: size, child: c);
      }
      return c;
    });
  }
}
