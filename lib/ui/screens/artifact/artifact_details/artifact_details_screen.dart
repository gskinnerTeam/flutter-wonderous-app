import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/app_loading_error.dart';
import 'package:wonders/ui/common/compass_divider.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/modals/fullscreen_url_img_viewer.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';

part 'widgets/_header.dart';
part 'widgets/_content.dart';
part 'widgets/_artifact_data_row.dart';

// TODO: GDS: add list shadow

class ArtifactDetailsScreen extends StatefulWidget {
  final String artifactId;
  const ArtifactDetailsScreen({Key? key, required this.artifactId}) : super(key: key);

  @override
  State<ArtifactDetailsScreen> createState() => _ArtifactDetailsScreenState();
}

class _ArtifactDetailsScreenState extends State<ArtifactDetailsScreen> {
  late final _future = searchLogic.getArtifactByID(widget.artifactId);

  @override
  Widget build(BuildContext context) {
    var preloadScreen = Stack(
      children: [
        BackBtn().safe(),
        Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: AppLoader(),
            ),
            Gap(context.insets.md),
            Text(
              'Just a moment, please...',
              style: context.textStyles.body.copyWith(color: context.colors.accent1),
            ),
          ],
        )),
      ],
    );

    return ColoredBox(
      color: context.colors.greyStrong,
      child: FutureBuilder<ArtifactData?>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.hasData == false) return preloadScreen;
          final data = snapshot.data;
          if (data == null) {
            return AppLoadError(label: 'Unable to find info for artifact ${widget.artifactId} ');
          }
          return Stack(children: [
            /// Content
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  elevation: 0,
                  leading: SizedBox.shrink(),
                  expandedHeight: context.heightPx * .5,
                  collapsedHeight: context.heightPx * .35,
                  flexibleSpace: _Header(data: data),
                ),
                SliverToBoxAdapter(child: _Content(data: data)),
              ],
            ),
            BackBtn().safe(),
          ]);
        },
      ),
    );
  }
}
