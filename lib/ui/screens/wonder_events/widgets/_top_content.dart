part of '../wonder_events.dart';

class _TopContent extends StatelessWidget {
  const _TopContent({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WonderEvents._topHeight,
      child: LightText(
        child: SeparatedColumn(
          separatorBuilder: () => Gap(context.insets.xs * 1.5),
          padding: EdgeInsets.only(top: context.insets.md, bottom: context.insets.sm),
          children: [
            /// Text and image in a stack
            Expanded(
              child: Stack(children: [
                /// Image with fade on btm
                Center(
                  child: _buildImageWithFade(context),
                ),

                /// Title text
                BottomCenter(
                  child: WonderTitleText(data),
                )
              ]),
            ),

            /// Bottom timeline
            SizedBox(
              height: 50,
              child: WondersTimelineBuilder(selectedWonders: [data.type]),
            ),
            _buildEraTextRow(context)
          ],
        ),
      ),
    );
  }

  Stack _buildImageWithFade(BuildContext context) {
    return Stack(
      children: [
        /// Image
        ClipPath(
          clipper: CurvedTopClipper(),
          child: Image.asset(
            data.type.flattened,
            width: 200,
            fit: BoxFit.cover,
            alignment: Alignment(0, -.5),
          ),
        ),

        /// Vertical gradient on btm
        Positioned.fill(
          child: BottomCenter(
            child: ListOverscollGradient(bottomUp: true),
          ),
        )
      ],
    );
  }

  Widget _buildEraTextRow(BuildContext context) {
    return SeparatedRow(
      separatorBuilder: () => Gap(context.insets.sm),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${data.startYr}  to  ${data.endYr}',
          style: context.text.body.copyWith(color: context.colors.accent2),
        ),
        _buildDot(context),
        Text(
          StringUtils.getEra(data.startYr),
          style: context.text.body.copyWith(color: context.colors.accent2),
        ),
      ],
    ).fx().fade(delay: context.times.pageTransition);
  }

  Container _buildDot(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(color: context.colors.accent2, borderRadius: BorderRadius.circular(99)),
    );
  }
}
