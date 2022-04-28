import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

/// To match designs:
/// - need a line-break after the first line
/// - of/the should be down-sized
/// Accomplished using a set of TextSpans, and a white list of 'small words'
class WonderTitleText extends StatelessWidget {
  const WonderTitleText(this.data, {Key? key, this.enableShadows = false}) : super(key: key);
  final WonderData data;
  final bool enableShadows;
  @override
  Widget build(BuildContext context) {
    var textStyle = context.textStyles.h1.copyWith(height: 1.15, fontSize: 52);
    bool smallText = [WonderType.christRedeemer, WonderType.colosseum].contains(data.type);
    if (smallText) {
      textStyle = textStyle.copyWith(fontSize: 48 * context.style.scale);
    }

    // First, get a list like: ['the\n', 'great wall']
    final title = data.title.toLowerCase();
    // Split on spaces, later, add either a linebreak or a space back in.
    List<String> pieces = title.split(' ');
    // TextSpan builder, figures out whether to use small text, and adds linebreak or space (or nothing).
    TextSpan buildTextSpan(String text) {
      final smallWords = ['of', 'the'];
      bool useSmallText = smallWords.contains(text.trim());
      int i = pieces.indexOf(text);
      bool addLinebreak = i == 0 && pieces.length > 1;
      bool addSpace = !addLinebreak && i < pieces.length - 1;
      return TextSpan(
        text: '${text.toUpperCase()}${addLinebreak ? '\n' : addSpace ? ' ' : ''}',
        style: useSmallText ? textStyle.copyWith(fontSize: 20) : textStyle,
      );
    }

    List<Shadow> shadows =
        enableShadows ? [Shadow(color: Colors.black.withOpacity(.6), offset: Offset(0, 2), blurRadius: 2)] : [];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle.copyWith(shadows: shadows),
        children: pieces.map(buildTextSpan).toList(),
      ),
    );
  }
}
