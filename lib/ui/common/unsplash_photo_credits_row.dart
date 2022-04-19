import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';

class UnsplashPhotoCreditsRow extends StatelessWidget {
  const UnsplashPhotoCreditsRow(this.data, {Key? key}) : super(key: key);
  final UnsplashPhotoData data;

  @override
  Widget build(BuildContext context) {
    void handleUserNamePressed() => appLogic.showWebView(context, data.photographerUrl);
    void handleUnsplashPressed() => appLogic.showWebView(context, UnsplashPhotoData.unsplashUrl);

    final style = context.text.caption.copyWith(color: context.colors.white, height: 1);
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(.5),
      child: Row(
        children: [
          Gap(context.insets.sm),
          Text('Photo by', style: style),
          TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  splashFactory: NoSplash.splashFactory,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Text(data.ownerUsername, style: style.copyWith(fontWeight: FontWeight.bold)),
              onPressed: handleUserNamePressed),
          Text(' on', style: style),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Unsplash', style: style.copyWith(fontWeight: FontWeight.bold)),
              onPressed: handleUnsplashPressed),
        ],
      ),
    );
  }
}
