import 'package:flutter/cupertino.dart';
import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/app_loading_error.dart';
import 'package:wonders/ui/common/compass_divider.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/modals/fullscreen_url_img_viewer.dart';

part 'widgets/_header.dart';
part 'widgets/_content.dart';

class ArtifactDetailsScreen extends StatefulWidget {
  const ArtifactDetailsScreen({Key? key, required this.artifactId}) : super(key: key);
  final String artifactId;

  @override
  State<ArtifactDetailsScreen> createState() => _ArtifactDetailsScreenState();
}

class _ArtifactDetailsScreenState extends State<ArtifactDetailsScreen> {
  late final _future = metAPILogic.getArtifactByID(widget.artifactId);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: $styles.colors.greyStrong,
      child: FutureBuilder<ArtifactData?>(
        future: _future,
        builder: (_, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData && data == null) {
            return AppLoadError(label: StringUtils.supplant($strings.artifactDetailsErrorNotFound, {'{artifactId}': widget.artifactId}));
          }

          return Stack(children: [
            /// Content
            !snapshot.hasData
                ? Center(child: AppLoader())
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        leading: SizedBox.shrink(),
                        expandedHeight: context.heightPx * .5,
                        collapsedHeight: context.heightPx * .35,
                        flexibleSpace: _Header(data: data!),
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
