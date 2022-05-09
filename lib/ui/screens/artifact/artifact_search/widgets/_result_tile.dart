part of '../artifact_search_screen.dart';

// TODO: GDS: handle image errors.

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
  bool _immediate = false, _error = false;

  @override
  void initState() {
    _listener = ImageStreamListener((info, b) {
      setState(() {
        _imageWidth = info.image.width;
        _imageHeight = info.image.height;
        _immediate = b;
      });
    }, onError: (_, __) => setState(() => _error = true));
    _load();
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
    setState(() {
      _imageWidth = _imageHeight = 0;
      _immediate = _error = false;
    });
    _stream?.removeListener(_listener);
    _image = CachedNetworkImageProvider(widget.data.imageUrl);
    _stream = _image!.resolve(ImageConfiguration());
    _stream!.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio =
        (widget.data.aspectRatio == 0) ? (widget.data.id % 10) / 15 + 0.6 : max(0.5, widget.data.aspectRatio);

    final BoxDecoration decoration = BoxDecoration(
      color: context.colors.black,
      borderRadius: BorderRadius.circular(context.insets.xs),
    );

    final Widget content = _imageWidth == 0
        ? Container(
            decoration: decoration,
            child: _error
                ? Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: context.colors.greyStrong,
                      size: context.insets.lg,
                    ),
                  )
                : null)
        : FXBuilder(
            key: ValueKey(widget.data.id),
            duration: _immediate ? 0.ms : 300.ms,
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
