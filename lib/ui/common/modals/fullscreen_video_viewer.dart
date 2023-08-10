import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
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
    params: const YoutubePlayerParams(),
  );

  bool get _enableVideo => PlatformInfo.isMobile;

  @override
  void initState() {
    super.initState();
    appLogic.supportedOrientationsOverride = [Axis.horizontal, Axis.vertical];
    RawKeyboard.instance.addListener(_handleKeyDown);
  }

  @override
  void dispose() {
    // when view closes, remove the override
    appLogic.supportedOrientationsOverride = null;
    RawKeyboard.instance.removeListener(_handleKeyDown);
    super.dispose();
  }

  Future<void> _handleKeyDown(RawKeyEvent value) async {
    if (value.repeat) return;
    if (value is RawKeyDownEvent) {
      final k = value.logicalKey;
      if (k == LogicalKeyboardKey.enter || k == LogicalKeyboardKey.space) {
        if (_enableVideo) {
          final state = await _controller.playerState;
          if (state == PlayerState.playing) {
            _controller.pauseVideo();
          } else {
            _controller.playVideo();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 9 / 9;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: (PlatformInfo.isMobile || kIsWeb)
                ? YoutubePlayer(
                    controller: _controller,
                    aspectRatio: aspect,
                  )
                : Placeholder(),
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
