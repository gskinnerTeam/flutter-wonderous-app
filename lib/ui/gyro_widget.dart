// import 'dart:async';
//
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:wonders/common_libs.dart';
// import 'package:wonders/ui/common/rotation_3d.dart';
//
// class GyroWidget extends StatefulWidget {
//   const GyroWidget({Key? key, required this.child}) : super(key: key);
//   final Widget child;
//
//   @override
//   State<GyroWidget> createState() => _GyroWidgetState();
// }
//
// class _GyroWidgetState extends State<GyroWidget> {
//   late StreamSubscription<AccelerometerEvent> _gryoListener;
//   double _rotX = 0;
//   double _rotY = 0;
//   double _rotZ = 0;
//   @override
//   void initState() {
//     super.initState();
//     _gryoListener = accelerometerEvents.listen((e) {
//       setState(() {
//         _rotX = e.x;
//         _rotY = e.y;
//         _rotZ = e.z;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _gryoListener.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(_rotX);
//     return Rotation3d(
//       useRads: true,
//       rotationX: _rotX,
//       //rotationY: -_rotY,
//       //rotationZ: _rotZ,
//       child: widget.child,
//     );
//   }
// }
