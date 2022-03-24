import 'dart:ui';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/unsplash_image.dart';
import 'package:wonders/ui/screens/image_gallery/image_gallery.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_bottom_menu.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_history_panel.dart';

class WonderDetailsScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WonderDetailsScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<WonderDetailsScreen> createState() => _WonderDetailsScreenState();
}

class _WonderDetailsScreenState extends State<WonderDetailsScreen>
    with GetItStateMixin, SingleTickerProviderStateMixin {
  late final _tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: app.selectedWondersTab.value,
  )..addListener(_handleTabChanged);
  GTweenerController? _fade;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    _fade?.forward(from: 0);
    // Hoist the selected tab up to the app controller, so it will be remembered when we return to this view.
    app.selectedWondersTab.value = _tabController.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersController w) => w.all);
    WonderData? wonder = wonders.firstWhereOrNull((w) => w.type == widget.type);
    wonder ??= wonders.first;
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          IndexedStack(
            index: _tabController.index,
            children: [
              WonderHistoryPanel(wonder),
              ImageGallery(photoIds: wonder.imageIds),
              _FrostedGlassSpike(),
              Padding(padding: EdgeInsets.only(bottom: 80), child: TimelineScreen(type: widget.type)),
            ],
          ).gTweener.fade().withInit((t) => _fade = t),
          TopRight(child: AppBtn(child: Text('Settings'), onPressed: _handleSettingsPressed)),
          BottomCenter(child: WonderDetailsBottomMenu(tabController: _tabController)),
        ],
      ),
    );
  }

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);
}

class _FrostedGlassSpike extends StatefulWidget {
  @override
  State<_FrostedGlassSpike> createState() => _FrostedGlassSpikeState();
}

class _FrostedGlassSpikeState extends State<_FrostedGlassSpike> {
  bool _isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Opacity(opacity: .5, child: UnsplashPhoto('huMh6cfhl_o', targetSize: 600))),
        Center(
          child: GestureDetector(
              onTap: () => setState(() => _isPanelOpen = !_isPanelOpen),
              child: AnimatedContainer(
                color: Colors.red,
                duration: context.times.fast,
                width: _isPanelOpen ? 200 : 80,
                height: _isPanelOpen ? 200 : 40,
                child: Center(
                  child: _isPanelOpen
                      ? Text('BIG', style: TextStyle(fontSize: 100))
                      : Text(
                          'Small!',
                        ),
                ),
              )
              // child: OpeningGlassCard(
              //   isOpen: _isPanelOpen,
              //   openBuilder: (_) => FlutterLogo(size: 200),
              //   closedBuilder: (_) => Text('Tap Me to Open!'),
              // ),
              ),
        )
      ],
    );
  }
}

class OpeningGlassCard extends StatelessWidget {
  OpeningGlassCard({Key? key, required this.closedBuilder, required this.openBuilder, required this.isOpen})
      : super(key: key);

  final Widget Function(BuildContext) closedBuilder;
  final Widget Function(BuildContext) openBuilder;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: context.times.fast,
      transitionBuilder: (child, anim) {
        return FadeTransition(child: child, opacity: anim);
      },
      child: GlassCard(
        key: ValueKey(isOpen),
        child: isOpen ? openBuilder(context) : closedBuilder(context),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.grey.shade600.withOpacity(.3))),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              child: child,
              padding: EdgeInsets.all(context.insets.lg),
            ),
          )
        ],
      ),
    );
  }
}
