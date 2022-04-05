import 'package:wonders/common_libs.dart';

class ArtifactHighlightsScreen extends StatefulWidget {
  final WonderType type;
  const ArtifactHighlightsScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ArtifactHighlightsScreen> createState() => _ArtifactScreenState();
}

class _ArtifactScreenState extends State<ArtifactHighlightsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Needs rotating image carousel. Ref: https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframes?node-id=785%3A7621
    // Show:
    // - wonder name,
    // - artifact name,
    // - artifact date,
    // - bar to indicate which of 6 preloaded artifacts are shown
    // - Browse all button (links to ArtifactSearchScreen)
    // - App navigator bar on bottom
    return Container();
  }
}
