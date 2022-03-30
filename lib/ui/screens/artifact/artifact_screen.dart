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
  bool isLiked = false;

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
    var _textBox = Padding(
      padding: EdgeInsets.symmetric(horizontal: context.style.insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title (or "loading" if artifact isn't loaded yet)
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.only(top: context.style.insets.lg),
              child: Text(artifact?.title ?? 'Loading...'),
            ),
          ),
          // Subtitle
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.only(top: context.style.insets.sm),
              child: Text(artifact?.year ?? ''),
            ),
          ),
          // Description
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.style.insets.lg),
              child: Text(artifact?.desc ?? ''),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        // Close button
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(context.insets.lg),
              child: const CloseButton(),
            ),
          ),
        ),

        // Like button
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(context.insets.lg),
              child: IconButton(
                icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  setState(() => isLiked = !isLiked);
                },
              ),
            ),
          ),
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
                  child: (artifact == null)
                      ?
                      // Progress indicator
                      Center(
                          child: CircularProgressIndicator(
                            color: context.colors.body,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: artifact!.image,
                          fit: BoxFit.fitHeight,
                          placeholder: (BuildContext context, String url) => const CircularProgressIndicator()),
                ),

                // Text section
                Expanded(flex: 1, child: _textBox),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
