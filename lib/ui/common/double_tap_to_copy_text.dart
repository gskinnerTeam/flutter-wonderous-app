import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';

class DoubleTapToCopyText extends StatelessWidget {
  final String text;
  final Widget child;

  const DoubleTapToCopyText({super.key, required this.text, required this.child});

  static void onCopyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: $styles.colors.greyStrong,
        content: Text($strings.scrollingContentCopiedToClipboard),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? GestureDetector(
      onDoubleTap: () => onCopyText(context, text),
      child: child,
    ) : child;
  }
}