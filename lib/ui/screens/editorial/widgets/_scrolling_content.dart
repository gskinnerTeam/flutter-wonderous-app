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

    DropCapText buildDropCapText(String value) => DropCapText(
          _fixNewlines(value),
          mode: DropCapMode.inside,
          style: context.textStyles.body,
          dropCapPadding: EdgeInsets.only(top: 2, right: 6),
          dropCapStyle: context.textStyles.dropCase.copyWith(color: context.colors.accent1, height: 1),
        );

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

      return HiddenCollectible(data.type, index: 0, matches: getTypesForSlot(slot));
    }

    return Container(
      color: context.colors.offWhite,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          buildHiddenCollectible(slot: 0),

          /// History 1
          buildDropCapText(data.historyInfo1),

          /// Pull Quote
          _CollapsingPullQuoteImage(data: data, scrollPos: scrollPos),
          buildHiddenCollectible(slot: 1),

          /// History 2
          buildText(data.historyInfo2),
          _SectionDivider(scrollPos, sectionNotifier, index: 1),

          /// Construction 1
          buildDropCapText(data.constructionInfo1),
          buildHiddenCollectible(slot: 2),
          _YouTubeThumbnail(id: data.videoId),

          /// Construction 2
          buildText(data.constructionInfo2),
          _SlidingImageStack(scrollPos: scrollPos, type: data.type),
          _SectionDivider(scrollPos, sectionNotifier, index: 2),

          /// Location
          buildDropCapText(data.locationInfo1),
          // SB: Disable maps thumbnail in debug mode, as it pollutes the logs too much in the android simulator
          //if (kReleaseMode) ...[
          _MapsThumbnail(data, height: 200),
          //],
          buildHiddenCollectible(slot: 3),
        ],
      ),
    );
  }
}

class _YouTubeThumbnail extends StatelessWidget {
  const _YouTubeThumbnail({Key? key, required this.id}) : super(key: key);
  final String id;

  String get imageUrl => 'http://img.youtube.com/vi/$id/hqdefault.jpg';

  @override
  Widget build(BuildContext context) {
    void handlePressed() => context.push(ScreenPaths.video(id));
    return AppBtn.basic(
      semanticLabel: 'Youtube thumbnail',
      onPressed: handlePressed,
      child: ImageFade(image: NetworkImage(imageUrl), fit: BoxFit.cover),
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
    return SizedBox(
      height: widget.height,
      child: AppBtn.basic(
        onPressed: handlePressed,
        semanticLabel: 'Maps Thumbnail',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.corners.md),
          child: GoogleMap(
            markers: {getMapsMarker(startPos.target)},
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: startPos,
          ),
        ),
      ),
    );
  }
}
