import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loading_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullscreenVideoPage extends StatefulWidget {
  const FullscreenVideoPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  late final _controller = YoutubePlayerController(
    initialVideoId: widget.id,
    params: const YoutubePlayerParams(autoPlay: true, startAt: Duration(seconds: 1)),
  )..play();

  @override
  void initState() {
    super.initState();
    appLogic.setDeviceOrientation(null);
  }

  @override
  void dispose() {
    appLogic.setDeviceOrientation(Axis.vertical);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double aspect = context.isLandscape ? MediaQuery.of(context).size.aspectRatio : 9 / 9;
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
                  YoutubePlayerIFrame(controller: _controller, aspectRatio: aspect),
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
