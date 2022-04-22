import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class ArtifactSearchResultsGrid extends StatelessWidget {
  const ArtifactSearchResultsGrid(
      {Key? key, required this.scrollController, required this.searchResults, required this.onPressed})
      : super(key: key);
  final void Function(ArtifactData) onPressed;
  final ScrollController scrollController;
  final List<ArtifactData?> searchResults;

  @override
  Widget build(BuildContext context) => MasonryGridView.count(
        shrinkWrap: true,
        controller: scrollController,
        crossAxisCount: 2,
        cacheExtent: 2000,
        crossAxisSpacing: context.insets.sm,
        mainAxisSpacing: context.insets.sm,
        itemCount: searchResults.length,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (BuildContext context, int index) {
          var data = searchResults[index];
          return _ImageItem(onPressed: onPressed, data: data!);
        },
      );
}

class _ImageItem extends StatelessWidget {
  const _ImageItem({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(ArtifactData data) onPressed;
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(data),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.insets.xs),
        child: Hero(
          tag: data.image,
          child: CachedNetworkImage(
            imageUrl: data.image,
            fit: BoxFit.cover,
            memCacheWidth: context.widthPx ~/ 2,
            placeholder: (_, __) => _ImagePlaceholder(),
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(child: AppLoader()),
    );
  }
}
