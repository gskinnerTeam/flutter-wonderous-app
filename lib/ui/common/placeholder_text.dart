import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/color_utils.dart';

class LoremPlaceholder extends StatelessWidget {
  const LoremPlaceholder({Key? key, this.dropCase = false, this.paragraphs = 1, this.words = 40}) : super(key: key);
  final bool dropCase;
  final int paragraphs;
  final int words;

  @override
  Widget build(BuildContext context) {
    final text = lorem(paragraphs: paragraphs, words: words);
    if (!dropCase) return Text(text, style: context.textStyles.body);
    return DropCapText(
      text,
      style: context.textStyles.body,
      dropCapPadding: EdgeInsets.only(right: context.insets.xs, top: 10),
      dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1),
    );
  }
}

class PlaceholderText extends StatefulWidget {
  const PlaceholderText({Key? key, this.count = 4}) : super(key: key);
  final int count;

  @override
  State<PlaceholderText> createState() => _PlaceholderTextState();
}

class _PlaceholderTextState extends State<PlaceholderText> {
  late List<Widget> _lines = _generateLines();

  @override
  void didUpdateWidget(covariant PlaceholderText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _lines = _generateLines();
  }

  @override
  Widget build(BuildContext context) => SeparatedColumn(children: _lines, separatorBuilder: () => Gap(11));

  List<Widget> _generateLines() {
    return List.generate(
      widget.count,
      (index) => Padding(
        padding: EdgeInsets.only(right: rnd.getInt(1, 4) * 20),
        child: Container(
            decoration: BoxDecoration(
                color: ColorUtils.shiftHsl(Colors.grey, rnd.getDouble(-.2, .2)),
                borderRadius: BorderRadius.circular(6)),
            height: 12,
            width: double.infinity),
      ),
    );
  }
}
