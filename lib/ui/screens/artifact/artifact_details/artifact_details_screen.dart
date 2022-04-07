import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_details/artifact_data_element.dart';

class ArtifactDetailsScreen extends StatefulWidget {
  final String id;
  const ArtifactDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtifactDetailsScreen> createState() => _ArtifactDetailsScreenState();
}

class _ArtifactDetailsScreenState extends State<ArtifactDetailsScreen> {
  ArtifactData? _artifact;
  final double _textHeight = 1.2;

  @override
  void initState() {
    super.initState();
    _getArtifact();
  }

  void _getArtifact() async {
    var newArtifact = await search.getArtifactByID(widget.id);
    setState(() => _artifact = newArtifact);
  }

  @override
  Widget build(BuildContext context) {
    // Create an image with a close button in the top right
    var header = Stack(
      children: [
        // Image
        Center(
          child: (_artifact == null)
              // Progress indicator
              ? Padding(
                  padding: EdgeInsets.all(context.insets.lg),
                  child: Center(
                    child: AppLoader(),
                  ),
                )
              // Actual rendered image
              : CachedNetworkImage(
                  imageUrl: _artifact!.image,
                  fit: BoxFit.fitHeight,
                  placeholder: (BuildContext context, String url) => const CircularProgressIndicator()),
        ),

        // Close button
        Positioned(
          top: context.insets.xs,
          right: context.insets.xs,
          child: GestureDetector(
            child: ClipOval(
              child: Container(
                color: context.colors.greyStrong,
                child: Padding(
                  padding: EdgeInsets.all(context.insets.xs),
                  child: CloseButton(color: context.colors.bg),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    // Create a grid of text fields, labels and content.
    var textBox = Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Wonder Type
          Padding(
            padding: EdgeInsets.only(top: context.insets.lg),
            child: Text(
              _artifact?.culture.toUpperCase() ?? '---',
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ),
          ),

          // Title (or "loading" if artifact isn't loaded yet)
          Padding(
            padding: EdgeInsets.only(top: context.insets.sm),
            child: Text(
              _artifact?.title ?? 'Loading...',
              textAlign: TextAlign.center,
              style: context.textStyles.h2.copyWith(color: context.colors.bg, height: _textHeight),
            ),
          ),

          // Compass rose line break
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.insets.xxl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: context.colors.accent2))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.insets.xs),
                  child: SvgPicture.asset(
                    './assets/images/compass-full.svg',
                    semanticsLabel: 'Line break',
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: context.colors.accent2))),
                  ),
                ),
              ],
            ),
          ),

          // Description
          Column(mainAxisSize: MainAxisSize.min, children: [
            ArtifactDataElement(title: 'Date', content: _artifact?.date ?? '---'),
            ArtifactDataElement(title: 'Period', content: _artifact?.period ?? '---'),
            ArtifactDataElement(title: 'Geography', content: _artifact?.country ?? '---'),
            ArtifactDataElement(title: 'Medium', content: _artifact?.medium ?? '---'),
            ArtifactDataElement(title: 'Dimension', content: _artifact?.dimension ?? '---'),
            ArtifactDataElement(title: 'Classification', content: _artifact?.classification ?? '---'),
          ]),
        ],
      ),
    );

    return Container(
      color: context.colors.greyStrong,
      child: CustomScrollView(
        cacheExtent: 2000,
        slivers: [
          // Header
          SliverToBoxAdapter(child: header),
          // Content
          SliverToBoxAdapter(child: textBox),
        ],
      ),
    );
  }
}
