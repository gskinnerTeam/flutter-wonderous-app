import 'package:flutter/material.dart';

class LightText extends StatelessWidget {
  const LightText({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.white),
        child: child,
      );
}

class DarkText extends StatelessWidget {
  const DarkText({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
        child: child,
      );
}
