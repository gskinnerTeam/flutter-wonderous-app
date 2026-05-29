import 'package:flutter/foundation.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/fullscreen_keyboard_listener.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullscreenVideoViewer extends StatefulWidget {
  const FullscreenVideoViewer({super.key, required this.id});
  final String id;

  @override
  State<FullscreenVideoViewer> createState() => _FullscreenVideoViewerState();
}

class _FullscreenVideoViewerState extends State<FullscreenVideoViewer> {
  late YoutubePlayerController _controller;

  bool get _enableVideo => PlatformInfo.isMobile || kIsWeb;

  @override
  void initState() {
    super.initState();
    appLogic.supportedOrientationsOverride = [Axis.horizontal, Axis.vertical];
    _controller = YoutubePlayerController(
      key: 'youtube-player',
      params: const YoutubePlayerParams(
        privacyEnhancedMode: true,
        enableCaption: true,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => loadPlayer());
  }

  void loadPlayer() {
    try {
      _controller.cueVideoByUrl(mediaContentUrl: 'https://www.youtube-nocookie.com/v/${widget.id}');
    } catch (e) {
      debugPrint('VP Error: $e');
    }
  }

  @override
  void dispose() {
    // when view closes, remove the override
    appLogic.supportedOrientationsOverride = null;
    _controller.close();
    super.dispose();
  }

  bool onKeyDownEvent(KeyDownEvent event) {
    if ((event.logicalKey == LogicalKeyboardKey.space || event.logicalKey == LogicalKeyboardKey.enter) &&
        _enableVideo) {
      _handleKeyDown(event).ignore();
      return true;
    }
    return false;
  }

  Future<KeyEventResult> _handleKeyDown(KeyDownEvent value) async {
    final state = await _controller.playerState;
    if (state == PlayerState.playing) {
      _controller.pauseVideo();
    } else {
      _controller.playVideo();
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    double aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : (16 / 9);

    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            FullscreenKeyboardListener(
              onKeyDown: onKeyDownEvent,
              child: Center(
                child: (PlatformInfo.isMobile || kIsWeb)
                    ? YoutubePlayer(
                        controller: _controller,
                        aspectRatio: aspect,
                      )
                    : Placeholder(),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all($styles.insets.md),
                child: PointerInterceptor(
                  child: const BackBtn(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
