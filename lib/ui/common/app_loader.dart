import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wonders/common_libs.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 40,
        height: 40,
        child: LoadingIndicator(colors: [context.colors.accent], indicatorType: Indicator.ballRotateChase),
      );
}
