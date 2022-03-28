import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class ArtifactScreen extends StatefulWidget {
  final String id;
  const ArtifactScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtifactScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactScreen> {
  ArtifactData? artifact;

  @override
  void initState() {
    super.initState();
    getArtifact();
  }

  void getArtifact() async {
    var newArtifact = await search.getArtifactByID(int.parse(widget.id));
    setState(() => artifact = newArtifact);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Close button
      SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: const CloseButton(),
          ),
        ),
      ),

      // Content
      Padding(
        padding: EdgeInsets.all(context.style.insets.lg),

        /// Scrolling timeline, manages a ScrollController.
        child: Flex(
          direction: context.isLandscape ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: (artifact == null)
                  ?
                  // Progress indicator
                  Center(
                      child: CircularProgressIndicator(
                        color: context.colors.fg,
                      ),
                    )
                  :
                  // Main image
                  CachedNetworkImage(
                      imageUrl: artifact!.image,
                      fit: BoxFit.fitHeight,
                      placeholder: (BuildContext context, String url) => const CircularProgressIndicator()),
            ),

            // Text section
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.style.insets.lg),
                  child: SingleChildScrollView(
                      child: Expanded(
                    child: Column(
                      children: [
                        // Title (or "loading" if artifact isn't loaded yet)
                        Padding(
                            padding: EdgeInsets.only(top: context.style.insets.lg),
                            child: Text(artifact?.title ?? 'Loading...')),
                        // Subtitle
                        Padding(
                            padding: EdgeInsets.only(top: context.style.insets.sm), child: Text(artifact?.year ?? '')),
                        // Description
                        Padding(
                            padding: EdgeInsets.only(top: context.style.insets.lg), child: Text(artifact?.desc ?? '')),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
