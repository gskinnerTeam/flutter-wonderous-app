part of '../editorial_screen.dart';

class FeaturedImages extends StatelessWidget {
  final ValueNotifier<double> scrollPos;
  final WonderType type;

  const FeaturedImages({Key? key, required this.scrollPos, required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 500,
      child: Stack(
        children: [
          Positioned.fill(child: Placeholder()),
          BottomLeft(
            child: ClipPath(
              clipper: CurvedTopClipper(flip: true),
              child: FractionallySizedBox(
                  heightFactor: .5,
                  widthFactor: .3,
                  child: Image.asset(
                    type.photo4,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          TopRight(
            child: ClipPath(
              clipper: CurvedTopClipper(),
              child: FractionallySizedBox(
                  widthFactor: .8,
                  heightFactor: .8,
                  child: Image.asset(
                    type.photo3,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
