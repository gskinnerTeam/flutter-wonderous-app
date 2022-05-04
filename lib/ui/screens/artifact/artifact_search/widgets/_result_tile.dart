part of '../artifact_search_screen.dart';

// TODO: GDS: update the Hero tag.

class _ResultTile extends StatefulWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(SearchData data) onPressed;
  final SearchData data;

  @override
  State<_ResultTile> createState() => _ResultTileState();
}

class _ResultTileState extends State<_ResultTile> {
  late final ImageStreamListener _listener;
  CachedNetworkImageProvider? _image;
  ImageStream? _stream;
  int _imageWidth = 0, _imageHeight = 0;

  @override
  void initState() {
    _listener = ImageStreamListener((info, _) {
      setState(() {
        _imageWidth = info.image.width;
        _imageHeight = info.image.height;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  @override
  void didUpdateWidget(_ResultTile oldWidget) {
    if (oldWidget.data != widget.data) _load();
    super.didUpdateWidget(oldWidget);
  }

  void _load() {
    _stream?.removeListener(_listener);
    _imageWidth = _imageHeight = 0;
    _image = CachedNetworkImageProvider(widget.data.imageUrl);
    _stream = _image!.resolve(ImageConfiguration());
    _stream!.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio =
        (widget.data.aspectRatio == 0) ? (widget.data.id % 10) / 20 + 0.7 : widget.data.aspectRatio;

    final BoxDecoration decoration = BoxDecoration(
      color: context.colors.white,
      borderRadius: BorderRadius.circular(context.insets.sm),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
    );

    final Widget content = _imageWidth == 0
        ? Container(decoration: decoration)
        : FXBuilder(
            key: ValueKey(widget.data.id),
            duration: 300.ms,
            builder: (_, ratio, __) => Container(
              decoration: decoration.copyWith(
                image: DecorationImage(
                  image: _image!,
                  opacity: ratio,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: BasicBtn(
        semanticLabel: widget.data.title,
        onPressed: () => widget.onPressed(widget.data),
        child: Expanded(child: content),
      ),
    );
  }
}
