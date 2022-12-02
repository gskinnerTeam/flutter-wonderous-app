part of '../artifact_carousel_screen.dart';

class _BottomTextContent extends StatelessWidget {
  const _BottomTextContent(
      {Key? key, required this.artifact, required this.height, required this.state, required this.shortMode})
      : super(key: key);

  final HighlightData artifact;
  final double height;
  final _ArtifactScreenState state;
  final bool shortMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: $styles.sizes.maxContentWidth2,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      alignment: Alignment.center,
      child: Stack(
        children: [
          /// Text
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap($styles.insets.xl),
              Column(
                children: [
                  IgnorePointer(
                    ignoringSemantics: false,
                    child: Semantics(
                      button: true,
                      onIncrease: () => state._handleArtifactTap(state._currentPage.value.round() + 1),
                      onDecrease: () => state._handleArtifactTap(state._currentPage.value.round() - 1),
                      // onTap: () => _handleArtifactTap(_currentOffset.round()),
                      liveRegion: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Force column to stretch horizontally so text is centered
                          SizedBox(width: double.infinity),
                          // Stop text from scaling to make layout a little easier, it's already quite large
                          StaticTextScale(
                            child: Text(
                              artifact.title,
                              overflow: TextOverflow.ellipsis,
                              style: $styles.text.h2.copyWith(color: $styles.colors.black, height: 1.2, fontSize: 32),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          if (!shortMode) ...[
                            Gap($styles.insets.xxs),
                            Text(
                              artifact.date.isEmpty ? '--' : artifact.date,
                              style: $styles.text.body,
                              textAlign: TextAlign.center,
                            ),
                          ]
                        ],
                      ).animate(key: ValueKey(artifact.artifactId)).fadeIn(),
                    ),
                  ),
                  Gap($styles.insets.sm),
                  if (!shortMode)
                    AppPageIndicator(
                      count: state._artifacts.length,
                      controller: state._pageController!,
                      semanticPageTitle: $strings.artifactsSemanticArtifact,
                    ),
                ],
              ),
              if (!shortMode) Gap($styles.insets.md),
              Spacer(),
              AppBtn.from(
                text: $strings.artifactsButtonBrowse,
                icon: AppIcons.search,
                expand: true,
                onPressed: state._handleSearchTap,
              ),
              Gap($styles.insets.lg),
            ],
          ),
        ],
      ),
    );
  }
}
