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
      padding: EdgeInsets.only(bottom: context.insets.md),
      color: Colors.black.withOpacity(.5),
      child: Row(
        children: [
          Gap(context.insets.sm),
          Text('Photo by ', style: style),
          BasicBtn(
              child: Text(data.ownerUsername, style: style.copyWith(fontWeight: FontWeight.bold)),
              onPressed: handleUserNamePressed,
              semanticLabel: data.ownerUsername),
          Text(' on', style: style),
          BasicBtn(
            semanticLabel: 'Unsplash',
            child: Text('Unsplash', style: style.copyWith(fontWeight: FontWeight.bold)),
            onPressed: handleUnsplashPressed,
          ),
        ],
      ),
    );
  }
}
