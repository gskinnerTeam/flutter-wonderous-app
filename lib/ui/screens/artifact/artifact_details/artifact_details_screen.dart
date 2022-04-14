import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/compass_divider.dart';
import 'package:wonders/ui/common/controls/circle_button.dart';
import 'package:wonders/ui/common/fullscreen_url_img_viewer.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';

part 'artifact_data_row.dart';

class ArtifactDetailsScreen extends StatefulWidget {
  final String artifactId;
  const ArtifactDetailsScreen({Key? key, required this.artifactId}) : super(key: key);

  @override
  State<ArtifactDetailsScreen> createState() => _ArtifactDetailsScreenState();
}

class _ArtifactDetailsScreenState extends State<ArtifactDetailsScreen> {
  ArtifactData? _data;

  @override
  void initState() {
    super.initState();
    _getArtifact();
  }

  /// Todo: Maybe use a futureBuilder here?
  void _getArtifact() async {
    var newArtifact = await searchLogic.getArtifactByID(widget.artifactId);
    _data = newArtifact;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void _handleClosePressed() => Navigator.pop(context);
    if (_data == null) return Center(child: Text('Error loading artifact.'));
    return ColoredBox(
      color: context.colors.greyStrong,
      child: Stack(children: [
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
              flexibleSpace: _TopContent(data: _data!),
            ),
            SliverToBoxAdapter(child: _BottomContent(data: _data!)),
          ],
        ),

        /// Back btn
        TopRight(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(context.insets.md),
              child: CircleButton(
                child: Icon(Icons.close, color: context.colors.white),
                bgColor: context.colors.greyStrong,
                onPressed: _handleClosePressed,
              ),
            ),
          ),
        )
      ]),
    );

    // Create an image with a close button in the top right
  }
}

class _TopContent extends StatelessWidget {
  const _TopContent({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    void _handleImagePressed() async {
      await Navigator.push(
        context,
        PageRoutes.fadeThrough(FullscreenUrlImgViewer(url: data.image)),
      );
    }

    return Stack(
      children: [
        BottomCenter(
          child: FractionalTranslation(
            translation: Offset(0, 1),
            child: SizedBox(
              height: 30,
              child: VtGradient([context.colors.greyStrong, context.colors.greyStrong.withOpacity(0)], const [.2, 1]),
            ),
          ),
        ),
        Container(
          color: context.colors.greyStrong,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: _handleImagePressed,
            child: Hero(
              tag: data.image,
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                placeholder: (BuildContext context, String url) => const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent({Key? key, required this.data}) : super(key: key);
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    const double _textHeight = 1.2;
    final animDelay = .25.seconds;
    final animDuration = context.times.slow * .5;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(context.insets.lg),

          // Wonder Type
          Text(
            data.culture.toUpperCase(),
            style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
          ).gTweener.fade().withDelay(animDelay).withDuration(animDuration),

          Gap(context.insets.sm),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: context.textStyles.h2.copyWith(color: context.colors.offWhite, height: _textHeight),
          ).gTweener.fade().withDelay(animDelay * 1.05).withDuration(animDuration),

          Gap(context.insets.xxl),

          FXRunAnimated((_, value) {
            return CompassDivider(isExpanded: !value, duration: context.times.med);
          }, delay: animDelay * 1.5),

          Gap(context.insets.xxl),

          // Description
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ArtifactDataRow(title: 'Date', content: data.date),
              ArtifactDataRow(title: 'Period', content: data.period),
              ArtifactDataRow(title: 'Geography', content: data.country),
              ArtifactDataRow(title: 'Medium', content: data.medium),
              ArtifactDataRow(title: 'Dimension', content: data.dimension),
              ArtifactDataRow(title: 'Classification', content: data.classification),
              Gap(context.heightPx * .15),
            ]
                .fx(interval: 70.ms)
                .fade(delay: animDelay * 1.55, duration: context.times.med)
                .slide(begin: Offset(.2, 0), curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }
}
