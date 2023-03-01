part of '../editorial_screen.dart';

class _ScrollingContent extends StatelessWidget {
  const _ScrollingContent(this.data, {Key? key, required this.scrollPos, required this.sectionNotifier})
      : super(key: key);
  final WonderData data;
  final ValueNotifier<double> scrollPos;
  final ValueNotifier<int> sectionNotifier;

  String _fixNewlines(String text) {
    const nl = '\n';
    final chunks = text.split(nl);
    while (chunks.last == nl) {
      chunks.removeLast();
    }
    chunks.removeWhere((element) => element.trim().isEmpty);
    final result = chunks.join('$nl$nl');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget buildText(String value) => Focus(child: Text(_fixNewlines(value), style: $styles.text.body));

    Widget buildDropCapText(String value) {
      final TextStyle dropStyle = $styles.text.dropCase;
      final TextStyle bodyStyle = $styles.text.body;
      final String dropChar = value.substring(0, 1);
      final textScale = MediaQuery.of(context).textScaleFactor;
      final double dropCapWidth = StringUtils.measure(dropChar, dropStyle).width * textScale;
      final bool skipCaps = !localeLogic.isEnglish;
      return Semantics(
        label: value,
        child: ExcludeSemantics(
          child: !skipCaps
              ? DropCapText(
                  _fixNewlines(value).substring(1),
                  dropCap: DropCap(
                    width: dropCapWidth,
                    height: $styles.text.body.fontSize! * $styles.text.body.height! * 2,
                    child: Transform.translate(
                      offset: Offset(0, bodyStyle.fontSize! * (bodyStyle.height! - 1) - 2),
                      child: Text(
                        dropChar,
                        overflow: TextOverflow.visible,
                        style: $styles.text.dropCase.copyWith(
                          color: $styles.colors.accent1,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  style: $styles.text.body,
                  dropCapPadding: EdgeInsets.only(right: 6),
                  dropCapStyle: $styles.text.dropCase.copyWith(
                    color: $styles.colors.accent1,
                    height: 1,
                  ),
                )
              : Text(value, style: bodyStyle),
        ),
      );
    }

    Widget buildHiddenCollectible({required int slot}) {
      List<WonderType> getTypesForSlot(slot) {
        switch (slot) {
          case 0:
            return [WonderType.chichenItza, WonderType.colosseum];
          case 1:
            return [WonderType.pyramidsGiza, WonderType.petra];
          case 2:
            return [WonderType.machuPicchu, WonderType.christRedeemer];
          default:
            return [WonderType.tajMahal, WonderType.greatWall];
        }
      }

      return HiddenCollectible(
        data.type,
        index: 0,
        matches: getTypesForSlot(slot),
        size: 128,
      );
    }

    return SliverBackgroundColor(
      color: $styles.colors.offWhite,
      sliver: SliverPadding(
        padding: EdgeInsets.symmetric(vertical: $styles.insets.md),
        sliver: SliverList(
          delegate: SliverChildListDelegate.fixed([
            Center(
              child: SizedBox(
                width: $styles.sizes.maxContentWidth1,
                child: Column(children: [
                  ..._contentSection([
                    Center(child: buildHiddenCollectible(slot: 0)),

                    /// History 1
                    buildDropCapText(data.historyInfo1),

                    /// Quote1
                    _CollapsingPullQuoteImage(data: data, scrollPos: scrollPos),
                    Center(child: buildHiddenCollectible(slot: 1)),

                    /// Callout1
                    _Callout(text: data.callout1),

                    /// History 2
                    buildText(data.historyInfo2),
                    _SectionDivider(scrollPos, sectionNotifier, index: 1),

                    /// Construction 1
                    buildDropCapText(data.constructionInfo1),
                    Center(child: buildHiddenCollectible(slot: 2)),
                  ]),
                  Gap($styles.insets.md),
                  _YouTubeThumbnail(id: data.videoId, caption: data.videoCaption),
                  Gap($styles.insets.md),
                  ..._contentSection([
                    /// Callout2
                    Gap($styles.insets.xs),
                    _Callout(text: data.callout2),

                    /// Construction 2
                    buildText(data.constructionInfo2),
                    _SlidingImageStack(scrollPos: scrollPos, type: data.type),
                    _SectionDivider(scrollPos, sectionNotifier, index: 2),

                    /// Location
                    buildDropCapText(data.locationInfo1),
                    _LargeSimpleQuote(text: data.pullQuote2, author: data.pullQuote2Author),
                    buildText(data.locationInfo2),
                  ]),
                  Gap($styles.insets.md),
                  AspectRatio(aspectRatio: 1.65, child: _MapsThumbnail(data)),
                  Gap($styles.insets.md),
                  ..._contentSection([Center(child: buildHiddenCollectible(slot: 3))]),
                  Gap(150),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  /// Helper widget to provide hz padding to multiple widgets. Keeps the layout of the scrolling content cleaner.
  List<Widget> _contentSection(List<Widget> children) {
    return [
      for (int i = 0; i < children.length - 1; i++) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
          child: children[i],
        ),
        Gap($styles.insets.md)
      ],
      Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
        child: children.last,
      ),
    ];
  }
}

class _YouTubeThumbnail extends StatelessWidget {
  const _YouTubeThumbnail({Key? key, required this.id, required this.caption}) : super(key: key);
  final String id;
  final String caption;

  String get imageUrl => 'http://img.youtube.com/vi/$id/hqdefault.jpg';

  @override
  Widget build(BuildContext context) {
    void handlePressed() => context.push(ScreenPaths.video(id));
    return MergeSemantics(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            AppBtn.basic(
              semanticLabel: $strings.scrollingContentSemanticYoutube,
              onPressed: handlePressed,
              child: Stack(children: [
                AppImage(image: NetworkImage(imageUrl), fit: BoxFit.cover, scale: 1.0),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all($styles.insets.xs),
                      decoration: BoxDecoration(
                        color: $styles.colors.black.withOpacity(0.66),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: $styles.colors.white,
                        size: $styles.insets.xl,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Gap($styles.insets.xs),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
                child: Text(caption, style: $styles.text.caption)),
          ],
        ),
      ),
    );
  }
}

class _MapsThumbnail extends StatefulWidget {
  const _MapsThumbnail(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  State<_MapsThumbnail> createState() => _MapsThumbnailState();
}

class _MapsThumbnailState extends State<_MapsThumbnail> {
  CameraPosition get startPos => CameraPosition(target: LatLng(widget.data.lat, widget.data.lng), zoom: 3);

  @override
  Widget build(BuildContext context) {
    void handlePressed() => context.push(ScreenPaths.maps(widget.data.type));
    if (PlatformInfo.isDesktop) return Placeholder();
    return MergeSemantics(
      child: Column(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular($styles.corners.md),
              child: AppBtn.basic(
                semanticLabel: $strings.scrollingContentSemanticOpen,
                onPressed: handlePressed,

                /// To prevent the map widget from absorbing the onPressed action, use a Stack + IgnorePointer + a transparent Container
                child: Stack(
                  children: [
                    Positioned.fill(child: ColoredBox(color: Colors.transparent)),
                    IgnorePointer(
                      child: GoogleMap(
                        markers: {getMapsMarker(startPos.target)},
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        initialCameraPosition: startPos,
                        myLocationButtonEnabled: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap($styles.insets.xs),
          Semantics(
            sortKey: OrdinalSortKey(0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
              child: Text(widget.data.mapCaption, style: $styles.text.caption),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverBackgroundColor extends SingleChildRenderObjectWidget {
  const SliverBackgroundColor({
    Key? key,
    required this.color,
    Widget? sliver,
  }) : super(key: key, child: sliver);

  final Color color;

  @override
  RenderSliverBackgroundColor createRenderObject(BuildContext context) {
    return RenderSliverBackgroundColor(
      color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverBackgroundColor renderObject) {
    renderObject.color = color;
  }
}

class RenderSliverBackgroundColor extends RenderProxySliver {
  RenderSliverBackgroundColor(this._color);

  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (value == color) {
      return;
    }
    _color = color;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && child!.geometry!.visible) {
      final SliverPhysicalParentData childParentData = child!.parentData! as SliverPhysicalParentData;
      final Rect childRect =
          offset + childParentData.paintOffset & Size(constraints.crossAxisExtent, child!.geometry!.paintExtent);
      context.canvas.drawRect(
          childRect,
          Paint()
            ..style = PaintingStyle.fill
            ..color = color);
      context.paintChild(child!, offset + childParentData.paintOffset);
    }
  }
}
