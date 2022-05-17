part of '../editorial_screen.dart';

class _Callout extends StatelessWidget {
  final String text;

  const _Callout({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(color: context.colors.accent1, width: 1),
          Gap(context.insets.sm),
          Expanded(
            child: Text(
              text,
              style: context.text.callout,
            ),
          )
        ],
      ),
    );
  }
}
