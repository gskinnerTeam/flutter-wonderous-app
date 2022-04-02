part of 'wonder_editorial_screen.dart';

class _EditorialContent extends StatelessWidget {
  const _EditorialContent(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    void handleVideoPressed() => context.push(ScreenPaths.video('cnMa-Sm9H4k'));
    return Container(
      color: context.colors.bg,
      padding: EdgeInsets.all(context.insets.md),
      child: SeparatedColumn(
        separatorBuilder: () => Gap(context.insets.md),
        children: [
          LoremPlaceholder(dropCase: true),
          GestureDetector(
            onTap: handleVideoPressed,
            child: SizedBox(
              height: 200,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: YouTubeUtils.getThumb('cnMa-Sm9H4k'),
              ),
            ),
          ),
          LoremPlaceholder(),
          PlaceholderImage(height: 400),
          LoremPlaceholder(),
          LoremPlaceholder(),
          LoremPlaceholder(),
          LoremPlaceholder(),
        ],
      ),
    );
  }
}
