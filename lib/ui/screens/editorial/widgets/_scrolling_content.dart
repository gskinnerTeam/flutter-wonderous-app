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
    Text buildText(String value) => Text(_fixNewlines(value), style: context.textStyles.body);

    DropCapText buildDropCapText(String value) {
      final dropStyle = context.text.dropCase;
      final bodyStyle = context.text.body;
      final dropChar = value.substring(0, 1);
      final dropCapSize = StringUtils.measure(dropChar, dropStyle);
      return DropCapText(
        _fixNewlines(value).substring(1),
        dropCap: DropCap(
          width: dropCapSize.width,
          height: context.textStyles.body.fontSize! * context.textStyles.body.height! * 2,
          child: Transform.translate(
            offset: Offset(0, bodyStyle.fontSize! * (bodyStyle.height! - 1) - 2),
            child: Text(value.substring(0, 1),
                style: context.textStyles.dropCase.copyWith(
                  color: context.colors.accent1,
                  height: 1,
                )),
          ),
        ),
        style: context.textStyles.body,
        dropCapPadding: EdgeInsets.only(top: 0, right: 6, bottom: 0),
        dropCapStyle: context.textStyles.dropCase.copyWith(
          color: context.colors.accent1,
          height: 1,
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

    return Container(
      color: context.colors.offWhite,
      padding: EdgeInsets.symmetric(vertical: context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          _ContentSection([
            buildHiddenCollectible(slot: 0),

            /// History 1
            buildDropCapText(data.historyInfo1),

            /// Quote1
            _CollapsingPullQuoteImage(data: data, scrollPos: scrollPos),
            buildHiddenCollectible(slot: 1),

            /// Callout1
            _Callout(text: data.callout1),

            /// History 2
            buildText(data.historyInfo2),
            _SectionDivider(scrollPos, sectionNotifier, index: 1),

            /// Construction 1
            buildDropCapText(data.constructionInfo1),
            buildHiddenCollectible(slot: 2),
          ]),

          _YouTubeThumbnail(id: data.videoId, caption: data.videoCaption),

          _ContentSection([
            /// Callout2
            Gap(context.insets.xs),
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

          // SB: Disable maps thumbnail in debug mode, as it pollutes the logs too much in the android simulator
          //if (kReleaseMode) ...[
          _MapsThumbnail(data, height: 200),
          //],
          _ContentSection([buildHiddenCollectible(slot: 3)]),
        ],
      ),
    );
  }
}

/// Helper widget to provide hz padding to multiple widgets. Keeps the layout of the scrolling content cleaner.
class _ContentSection extends StatelessWidget {
  _ContentSection(this.children, {Key? key}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.insets.md),
        child: SeparatedColumn(separatorBuilder: () => Gap(context.insets.md), children: children),
      );
}

class _YouTubeThumbnail extends StatelessWidget {
  const _YouTubeThumbnail({Key? key, required this.id, required this.caption}) : super(key: key);
  final String id;
  final String caption;

  String get imageUrl => 'http://img.youtube.com/vi/$id/hqdefault.jpg';

  @override
  Widget build(BuildContext context) {
    void handlePressed() => context.push(ScreenPaths.video(id));
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Column(
        children: [
          AppBtn.basic(
            semanticLabel: 'Youtube thumbnail',
            onPressed: handlePressed,
            child: ImageFade(image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
          Gap(context.insets.xs),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: Text(caption, style: context.text.caption)),
        ],
      ),
    );
  }
}

class _MapsThumbnail extends StatefulWidget {
  const _MapsThumbnail(this.data, {Key? key, required this.height}) : super(key: key);
  final WonderData data;
  final double height;

  @override
  State<_MapsThumbnail> createState() => _MapsThumbnailState();
}

class _MapsThumbnailState extends State<_MapsThumbnail> {
  CameraPosition get startPos => CameraPosition(target: LatLng(widget.data.lat, widget.data.lng), zoom: 3);

  @override
  Widget build(BuildContext context) {
    void handlePressed() => context.push(ScreenPaths.maps(widget.data.type));
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.corners.md),
            child: AppBtn.basic(
              semanticLabel: 'Open fullscreen maps view',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(context.insets.xs),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.insets.md),
          child: Text(widget.data.mapCaption, style: context.text.caption),
        ),
      ],
    );
  }
}
