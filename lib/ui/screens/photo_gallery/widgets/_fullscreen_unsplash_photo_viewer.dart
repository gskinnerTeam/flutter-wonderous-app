part of '../photo_gallery.dart';

class _FullScreenUnsplashPhotoViewer extends StatefulWidget {
  const _FullScreenUnsplashPhotoViewer(this.initialId, this.idList, {Key? key}) : super(key: key);
  final String initialId;
  final List<String> idList;

  @override
  State<_FullScreenUnsplashPhotoViewer> createState() => _FullScreenUnsplashPhotoViewerState();
}

class _FullScreenUnsplashPhotoViewerState extends State<_FullScreenUnsplashPhotoViewer> {
  late String _id = widget.initialId;

  void incrementId(int amt) {
    int idx = ((widget.idList.indexOf(_id) + amt) % widget.idList.length).abs();
    setState(() => _id = widget.idList[idx]);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.black,
      child: Stack(
        children: [
          InteractiveViewer(
            child: UnsplashPhoto(
              _id,
              fit: BoxFit.contain,
              size: UnsplashPhotoSize.xl,
              showCredits: true,
            ),
          ),
          BackBtn().safe(),
        ],
      ),
    );
  }
}
