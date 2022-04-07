import 'package:wonders/common_libs.dart';

enum ArchType { spade, pyramid }

class ArchClipper extends CustomClipper<Path> {
  ArchClipper(this.type);
  final ArchType type;

  @override
  Path getClip(Size size) {
    final pts = _getArchPts(size, type);
    // Points start at bottom left corner, and go clock-wise
    var clip = Path()..moveTo(pts[0].pos.dx, pts[0].pos.dy);
    for (var i = 1; i < pts.length; i++) {
      final p = pts[i];
      clip.quadraticBezierTo(p.control.dx, p.control.dy, p.pos.dx, p.pos.dy);
    }
    clip.lineTo(pts[0].pos.dx, pts[0].pos.dy);
    return clip;
  }

  @override
  bool shouldReclip(covariant ArchClipper oldClipper) => true || oldClipper.type != type;
}

class ArchPoint {
  ArchPoint(this.pos, [Offset? control]) {
    this.control = control ?? pos;
  }
  final Offset pos;
  late final Offset control;

  static ArchPoint lerp(ArchPoint ptA, ArchPoint ptB, double t) {
    return ArchPoint(
      Offset.lerp(ptA.pos, ptB.pos, t) ?? Offset.zero,
      Offset.lerp(ptA.control, ptB.control, t) ?? Offset.zero,
    );
  }
}

/// TODO: Refactor this to just allow each type to work on path directly
/// This make it easier to match the shapes we need, but won't really be tweenable from shape to shape
/// Certain ones can still shared the same 5-point structure / draw method
List<ArchPoint> _getArchPts(Size size, ArchType type) {
  double distanceFromTop = 100;
  switch (type) {
    case ArchType.pyramid:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, distanceFromTop)),
        ArchPoint(Offset(size.width / 2, 0)),
        ArchPoint(Offset(size.width, distanceFromTop)),
        ArchPoint(Offset(size.width, size.height)),
      ];

    case ArchType.spade:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, distanceFromTop)),
        ArchPoint(Offset(size.width / 2, 0), Offset(0, distanceFromTop * .66)),
        ArchPoint(Offset(size.width, distanceFromTop), Offset(size.width, distanceFromTop * .66)),
        ArchPoint(Offset(size.width, size.height)),
      ];
  }
}

class CurvedTopClipper extends CustomClipper<Path> {
  CurvedTopClipper({this.flip = false});
  final bool flip;

  @override
  Path getClip(Size size) {
    double curvePt = size.height * .33;
    var path = Path();
    if (flip) {
      path.lineTo(0, size.height - curvePt);
      path.arcToPoint(
        Offset(size.width, size.height - curvePt),
        radius: Radius.circular(curvePt / 2),
        clockwise: false,
      );
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(0, curvePt);
      path.arcToPoint(
        Offset(size.width, curvePt),
        radius: Radius.circular(curvePt / 2),
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    return path;
  }

  @override
  bool shouldReclip(CurvedTopClipper oldClipper) => true || oldClipper.flip != flip;
}
