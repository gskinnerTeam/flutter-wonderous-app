import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loading_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullscreenVideoViewer extends StatefulWidget {
  const FullscreenVideoViewer({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<FullscreenVideoViewer> createState() => _FullscreenVideoViewerState();
}

class _FullscreenVideoViewerState extends State<FullscreenVideoViewer> {
  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: widget.id,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  void initState() {
    super.initState();
    appLogic.supportedOrientationsOverride = [Axis.horizontal, Axis.vertical];
  }

  @override
  void dispose() {
    // when view closes, remove the override
    appLogic.supportedOrientationsOverride = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 9 / 9;
    return Scaffold(
      backgroundColor: Colors.black,
      body: YoutubePlayerScaffold(
        controller: _controller,
        aspectRatio: aspect,
        builder: (_, player) => Stack(
          children: [
            player,
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all($styles.insets.md),
                child: const BackBtn(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
