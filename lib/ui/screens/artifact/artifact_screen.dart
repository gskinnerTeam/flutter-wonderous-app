import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

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
    var newArtifact = await search.getArtifactByID(int.parse(widget.id));
    setState(() => _artifact = newArtifact);
  }

  @override
  Widget build(BuildContext context) {
    // Create a grid of text fields, labels and content.
    var textBox = Padding(
      padding: EdgeInsets.symmetric(horizontal: context.style.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Type
          Padding(
            padding: EdgeInsets.only(top: context.style.insets.lg),
            child: Text(
              widget.type.name,
              style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent1),
            ),
          ),

          // Title (or "loading" if artifact isn't loaded yet)
          Padding(
            padding: EdgeInsets.only(top: context.style.insets.lg),
            child: Text(
              _artifact?.title ?? 'Loading...',
              style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent1),
            ),
          ),

          // TODO - compass rose line break here

/*
          // Description
          GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), children: [
            Text(
              'Label',
              style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent2),
            ),
            Text('A whole bunch of data parameters!',
                style: context.textStyles.titleFont.copyWith(color: context.style.colors.bg)),
            Text(
              'Label',
              style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent2),
            ),
            Text('A whole bunch of data parameters!',
                style: context.textStyles.titleFont.copyWith(color: context.style.colors.bg)),
            Text(
              'Label',
              style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent2),
            ),
            Text('A whole bunch of data parameters!',
                style: context.textStyles.titleFont.copyWith(color: context.style.colors.bg)),
          ])

*/

          /*
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: EdgeInsets.only(right: context.style.insets.md),
                  child: Text(
                    'Label',
                    style: context.textStyles.titleFont.copyWith(color: context.style.colors.accent2),
                  )),
              Text('A whole bunch of data parameters!',
                  style: context.textStyles.titleFont.copyWith(color: context.style.colors.bg)),
            ])
          ])),
          */
        ],
      ),
    );

    return Container(
      color: context.style.colors.greyStrong,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Close button
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ClipOval(
                  child: Container(
                    color: context.style.colors.greyStrong,
                    child: Padding(
                      padding: EdgeInsets.all(context.insets.md),
                      child: const CloseButton(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: Center(
              child: Flex(
                direction: context.isLandscape ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    flex: 1,
                    child: (_artifact == null)
                        ?
                        // Progress indicator
                        Center(
                            child: CircularProgressIndicator(
                              color: context.colors.body,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: _artifact!.image,
                            fit: BoxFit.fitHeight,
                            placeholder: (BuildContext context, String url) => const CircularProgressIndicator()),
                  ),

                  // Text section
                  Expanded(flex: 1, child: textBox),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
