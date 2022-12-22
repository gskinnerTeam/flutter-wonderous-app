import 'package:wonders/common_libs.dart';

enum ArchType { spade, pyramid, arch, wideArch, flatPyramid }

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
  bool shouldReclip(covariant ArchClipper oldClipper) => oldClipper.type != type;
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

List<ArchPoint> _getArchPts(Size size, ArchType type) {
  double distanceFromTop = size.width / 3;
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
    case ArchType.arch:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, size.width / 2)),
        ArchPoint(Offset(size.width / 2, 0), Offset(0, 0)),
        ArchPoint(Offset(size.width, size.width / 2), Offset(size.width, 0)),
        ArchPoint(Offset(size.width, size.height)),
      ];
    case ArchType.wideArch:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, size.width / 2)),
        ArchPoint(Offset(0, distanceFromTop)),
        ArchPoint(Offset(size.width / 2, 0), Offset(0, 0)),
        ArchPoint(Offset(size.width, distanceFromTop), Offset(size.width, 0)),
        ArchPoint(Offset(size.width, size.width / 2)),
        ArchPoint(Offset(size.width, size.height)),
      ];
    case ArchType.flatPyramid:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, distanceFromTop)),
        ArchPoint(Offset(size.width * 0.8 / 2, 0)),
        ArchPoint(Offset(size.width * 1.2 / 2, 0)),
        ArchPoint(Offset(size.width, distanceFromTop)),
        ArchPoint(Offset(size.width, size.height)),
      ];
  }
}

class CurvedTopClipper extends CustomClipper<Path> {
  CurvedTopClipper({this.flip = false});
  final bool flip;

  @override
  Path getClip(Size size) {
    double radius = size.width / 2;
    var path = Path();
    if (flip) {
      // path.addOval(Rect.fromCircle(center: Offset.zero, radius: 40));
      path.lineTo(0, size.height - radius);
      path.arcToPoint(
        Offset(size.width, size.height - radius),
        radius: Radius.circular(size.width / 2),
        clockwise: false,
      );
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(0, radius);
      path.arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius / 2),
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    return path;
  }

  @override
  bool shouldReclip(CurvedTopClipper oldClipper) => oldClipper.flip != flip;
}
