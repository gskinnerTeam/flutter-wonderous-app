import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/color_utils.dart';
import 'package:wonders/logic/utils/rnd.dart';

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
