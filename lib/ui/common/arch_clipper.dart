import 'package:wonders/common_libs.dart';

enum ArchType {
  spade,
  rect,
}

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

  // List<ArchPoint> lerpPoints(List<ArchPoint> pts1, List<ArchPoint> pts2, double d) {
  //   assert(pts1.length == pts2.length, 'pts1 and pts2 should have the same number of items.');
  //   List<ArchPoint> result = [];
  //   for (var i = 0; i < pts1.length; i++) {
  //     result.add(ArchPoint.lerp(pts1[i], pts2[i], d));
  //   }
  //   return result;
  // }
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
  switch (type) {
    case ArchType.spade:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, min(size.height * .3, 200))),
        ArchPoint(Offset(size.width / 2, 0), Offset(0, size.height * .2)),
        ArchPoint(Offset(size.width, min(size.height * .3, 200)), Offset(size.width, size.height * .2)),
        ArchPoint(Offset(size.width, size.height)),
      ];
    case ArchType.rect:
      return [
        ArchPoint(Offset(0, size.height)),
        ArchPoint(Offset(0, 0)),
        ArchPoint(Offset(size.width / 2, 0)),
        ArchPoint(Offset(size.width, 0)),
        ArchPoint(Offset(size.width, size.height)),
      ];
  }
}
