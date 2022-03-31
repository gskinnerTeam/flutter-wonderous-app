import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

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
          child: Flex(
            direction: context.isLandscape ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: (_artifact == null)
                    ?
                    // Progress indicator
                    Center(
                        child: AppLoader(),
                      )
                    : CachedNetworkImage(
                        imageUrl: _artifact!.image,
                        fit: BoxFit.fitHeight,
                        placeholder: (BuildContext context, String url) => const CircularProgressIndicator()),
              ),
            ],
          ),
        ),

        // Close button
        Positioned(
          top: 0,
          right: 0,
          child: ClipOval(
            child: Container(
              color: context.colors.greyStrong,
              child: Padding(
                padding: EdgeInsets.all(context.insets.md),
                child: const CloseButton(),
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Type
          Padding(
            padding: EdgeInsets.only(top: context.insets.lg),
            child: Text(
              widget.type.name,
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ),
          ),

          // Title (or "loading" if artifact isn't loaded yet)
          Padding(
            padding: EdgeInsets.only(top: context.insets.lg),
            child: Text(
              _artifact?.title ?? 'Loading...',
              style: context.textStyles.titleFont.copyWith(color: context.colors.accent1),
            ),
          ),

          // TODO - compass rose line break here
          Padding(
              padding: EdgeInsets.symmetric(vertical: context.insets.sm),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3, color: context.colors.accent2))),
              )),

          // Description
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                Text(
                  'Label',
                  style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
                ),
                Text('A whole bunch of data parameters!',
                    style: context.textStyles.titleFont.copyWith(color: context.colors.bg)),
                Text(
                  'Label',
                  style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
                ),
                Text('A whole bunch of data parameters!',
                    style: context.textStyles.titleFont.copyWith(color: context.colors.bg)),
                Text(
                  'Label',
                  style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
                ),
                Text('A whole bunch of data parameters!',
                    style: context.textStyles.titleFont.copyWith(color: context.colors.bg)),
              ],
            ),
          )

          /*
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: EdgeInsets.only(right: context.insets.md),
                  child: Text(
                    'Label',
                    style: context.textStyles.titleFont.copyWith(color: context.colors.accent2),
                  )),
              Text('A whole bunch of data parameters!',
                  style: context.textStyles.titleFont.copyWith(color: context.colors.bg)),
            ])
          ])),
          */
        ],
      ),
    );

    return Container(
      color: context.colors.greyStrong,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header
          header,

          // Content
          Expanded(child: textBox),
        ],
      ),
    );
  }
}
