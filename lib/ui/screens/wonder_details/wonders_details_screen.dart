import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_bottom_menu.dart';

class WonderDetailsScreen extends StatelessWidget with GetItMixin {
  WonderDetailsScreen({Key? key, required this.type}) : super(key: key);
  final WonderType? type;

  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersController w) => w.all);
    WonderData? wonder = wonders.firstWhereOrNull((w) => w.type == type);
    wonder ??= wonders.first;
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true,
              flexibleSpace: WonderIllustration(wonder.type),
              expandedHeight: 220,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(context.insets.lg),
                child: SeparatedColumn(
                  separatorBuilder: () => Gap(context.insets.xl),
                  children: [
                    // History
                    _HistoryInfo(),
                    _PlaceholderThumb(
                      'Gallery Images',
                      height: 300,
                      onPressed: () => context.push(ScreenPaths.wonderGallery(WonderType.petra)),
                    ),
                    PlaceholderLines(count: 6),
                    _PlaceholderThumb('Video', height: 400, onPressed: () {}),
                    // Artifacts
                    _ArtifactsInfo(),
                    _PlaceholderThumb('Artifact Images', onPressed: () {}),
                    // Timeline
                    _TimelineInfo(),
                    _PlaceholderThumb(
                      'Timeline Thumbnail',
                      onPressed: () => context.push(ScreenPaths.timeline(WonderType.petra)),
                    ),
                    PlaceholderLines(count: 3),
                    // GeographyInfo
                    _GeographyInfo(),
                    _PlaceholderThumb('Map  Thumbnail', onPressed: () {}),
                  ],
                ),
              ),
            ),
          ]),
        ),
        WonderDetailsBottomMenu(),
      ],
    );
  }
}

class _HistoryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _TitledInfo('History', PlaceholderLines(count: 12));
}

class _ArtifactsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _TitledInfo('Artifacts', PlaceholderLines(count: 6));
}

class _TimelineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _TitledInfo('Timeline', PlaceholderLines(count: 4));
}

class _GeographyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _TitledInfo('Geography', PlaceholderLines(count: 4));
}

class _TitledInfo extends StatelessWidget {
  const _TitledInfo(this.title, this.child, {Key? key}) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyles.h2),
        Gap(context.insets.med),
        child,
      ],
    );
  }
}

class _PlaceholderThumb extends StatelessWidget {
  const _PlaceholderThumb(this.label, {Key? key, this.height = 200, required this.onPressed}) : super(key: key);
  final String label;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => AppBtn(
        onPressed: onPressed,
        child: Container(
          color: Colors.grey,
          width: double.infinity,
          alignment: Alignment.center,
          height: height,
          child: Text(label, style: context.textStyles.h1),
        ),
      );
}
