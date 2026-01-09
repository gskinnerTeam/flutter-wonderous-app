import 'package:wonders/common_libs.dart';

class GlobalInteractions {
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
}