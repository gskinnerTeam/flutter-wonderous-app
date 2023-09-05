// ignore_for_file: constant_identifier_names
import 'package:wonders/common_libs.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {Key? key, this.size = 22, this.color}) : super(key: key);
  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String i = icon.name.toLowerCase().replaceAll('_', '-');
    String path = 'assets/images/_common/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path,
            width: size, height: size, color: color ?? $styles.colors.offWhite, filterQuality: FilterQuality.high),
      ),
    );
  }
}

enum AppIcons {
  close,
  close_large,
  collection,
  download,
  expand,
  fullscreen,
  fullscreen_exit,
  info,
  menu,
  next_large,
  north,
  prev,
  reset_location,
  search,
  share_android,
  share_ios,
  timeline,
  wallpaper,
  zoom_in,
  zoom_out
}
