import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: context.colors.greyStrong.withOpacity(.5),
      ),
    );
  }
}
