import 'package:wonders/common_libs.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    Key? key,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: style, textAlign: textAlign, maxLines: maxLines);
  }
}
