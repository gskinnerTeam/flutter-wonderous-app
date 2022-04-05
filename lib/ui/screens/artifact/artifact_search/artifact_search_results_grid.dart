import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

class ArtifactSearchResultsGrid extends StatelessWidget {
  const ArtifactSearchResultsGrid({Key? key, required this.searchResults, required this.onClick}) : super(key: key);
  final void Function(ArtifactData) onClick;
  final List<ArtifactData?> searchResults;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: 2000,
      slivers: [
        SliverToBoxAdapter(
          child: MasonryGridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: context.insets.sm,
            mainAxisSpacing: context.insets.sm,
            itemCount: searchResults.length,
            clipBehavior: Clip.antiAlias,
            itemBuilder: (BuildContext context, int index) {
              var data = searchResults[index];
              return GestureDetector(
                onTap: () => onClick(data!),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.insets.xs),
                  child: CachedNetworkImage(
                      imageUrl: data!.image,
                      placeholder: (BuildContext context, String url) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
                              border: Border.all(color: context.colors.accent2, width: 3)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Center(
                              heightFactor: 1,
                              child: AppLoader(),
                            ),
                          ),
                        );
                      }),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
