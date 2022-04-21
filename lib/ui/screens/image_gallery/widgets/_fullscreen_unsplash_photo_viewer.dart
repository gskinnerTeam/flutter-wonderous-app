part of '../image_gallery.dart';

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
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: UnsplashPhoto(
                _id,
                fit: BoxFit.fitHeight,
                size: UnsplashPhotoSize.xl,
                showCredits: true,
              ),
            ),
          ),
          ColoredBox(
            color: context.colors.greyStrong,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AppIconBtn(
                    Icons.chevron_left,
                    size: 48,
                    onPressed: () => incrementId(1),
                  ),
                ),
                AppIconBtn(
                  Icons.close,
                  size: 32,
                  onPressed: () => Navigator.pop(context, _id),
                ),
                Expanded(
                  child: AppIconBtn(
                    Icons.chevron_right,
                    size: 48,
                    onPressed: () => incrementId(-1),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
