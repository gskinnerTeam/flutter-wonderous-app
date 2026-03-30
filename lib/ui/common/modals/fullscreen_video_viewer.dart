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
    appLogic.supportedOrientationsOverride = [Axis.horizontal, Axis.vertical];
    _controller = YoutubePlayerController(
      key: 'youtube-player',
      params: const YoutubePlayerParams(
        origin: 'https://www.youtube-nocookie.com',
        enableCaption: false,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => loadPlayer());
    super.initState();
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

  bool onKeyEvent(KeyEvent event) {
    _handleKeyDown(event);
    return true;
  }

  Future<KeyEventResult> _handleKeyDown(KeyEvent value) async {
    if (value is KeyRepeatEvent) return KeyEventResult.ignored;
    if (value is KeyDownEvent) {
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
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    double aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 9 / 9;

    PlatformDispatcher.instance.onError = (error, stack) {
      return true;
    };
    
    return YoutubePlayerScaffold(
      backgroundColor: Colors.black,
      controller: _controller,
      aspectRatio: aspect,
      builder:(context, player) => Stack(
        children: [
          FullscreenKeyboardListener(
            onKeyDown: onKeyEvent,
            child: Center(
              child: (PlatformInfo.isMobile || kIsWeb) ? player : Placeholder(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all($styles.insets.md),
              // Wrap btn in a PointerInterceptor to prevent the HTML video player from intercepting the pointer (https://pub.dev/packages/pointer_interceptor)
              child: PointerInterceptor(
                child: const BackBtn(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
