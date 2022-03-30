import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/unsplash_image.dart';

class FullScreenPhotoViewer extends StatefulWidget {
  const FullScreenPhotoViewer(this.initialId, this.idList, {Key? key}) : super(key: key);
  final String initialId;
  final List<String> idList;

  @override
  State<FullScreenPhotoViewer> createState() => _FullScreenPhotoViewerState();
}

class _FullScreenPhotoViewerState extends State<FullScreenPhotoViewer> {
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
              child: UnsplashPhoto(_id, fit: BoxFit.cover, targetSize: context.diagonalPx.round()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: AppBtn(
                  child: Icon(Icons.chevron_left, size: 48),
                  onPressed: () => incrementId(1),
                ),
              ),
              AppBtn(
                child: Icon(Icons.close, size: 32),
                onPressed: () => Navigator.pop(context, _id),
              ),
              Expanded(
                child: AppBtn(
                  child: Icon(Icons.chevron_right, size: 48),
                  onPressed: () => incrementId(-1),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
