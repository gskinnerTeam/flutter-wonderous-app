import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/artifact/artifact_data_element.dart';

class ArtifactScreen extends StatefulWidget {
  final WonderType type;
  final String id;
  const ArtifactScreen({Key? key, required this.type, required this.id}) : super(key: key);

  @override
  State<ArtifactScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactScreen> {
  ArtifactData? _artifact;

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
              widget.type.name.toUpperCase(),
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ),
          ),

          // Title (or "loading" if artifact isn't loaded yet)
          Padding(
            padding: EdgeInsets.only(top: context.insets.sm),
            child: Text(
              _artifact?.title ?? 'Loading...',
              style: context.textStyles.h2.copyWith(color: context.colors.bg),
            ),
          ),

          // TODO - compass rose line break here
          Padding(
              padding: EdgeInsets.symmetric(vertical: context.insets.xxl),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: context.colors.accent2))),
              )),

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
