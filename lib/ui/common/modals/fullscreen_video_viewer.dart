import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loading_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullscreenVideoPage extends StatefulWidget {
  const FullscreenVideoPage({super.key, required this.id});

  final String id;

  @override
  State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.id,
      autoPlay: true,
      startSeconds: 1,
    );
    appLogic.setDeviceOrientation(null);
  }

  @override
  void dispose() {
    _controller.close();
    // when view closes, restore the supported orientations
    appLogic.setDeviceOrientation(appLogic.supportedOrientations);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 1.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: aspect,
              child: Stack(
                children: [
                  const Center(child: AppLoadingIndicator()),
                  YoutubePlayer(
                    controller: _controller,
                    aspectRatio: aspect,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all($styles.insets.md),
              child: const BackBtn(),
            ),
          ),
        ],
      ),
    );
  }
}
