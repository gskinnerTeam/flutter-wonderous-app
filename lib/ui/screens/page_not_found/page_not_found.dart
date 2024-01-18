import 'package:flutter/material.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/wonderous_logo.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound(String url, {super.key});

  @override
  Widget build(BuildContext context) {
    void handleHomePressed() => context.go(ScreenPaths.home);

    return Scaffold(
      backgroundColor: $styles.colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WonderousLogo(),
            Gap(10),
            Text(
              'Wonderous',
              style: $styles.text.wonderTitle.copyWith(color: $styles.colors.accent1, fontSize: 28),
            ),
            Gap(70),
            Text(
              'The page you are looking for does not exist.',
              style: $styles.text.body.copyWith(color: $styles.colors.offWhite),
            ),
            Gap(70),
            AppBtn(
              minimumSize: Size(200, 0),
              bgColor: $styles.colors.offWhite,
              onPressed: handleHomePressed,
              semanticLabel: 'Back',
              child: DarkText(
                child: Text(
                  'Back to civilization',
                  style: $styles.text.btn.copyWith(fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
