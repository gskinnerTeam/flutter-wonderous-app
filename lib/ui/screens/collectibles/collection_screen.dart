

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';

class CollectionScreen extends StatelessWidget {
  CollectionScreen({String? fromId, Key? key}) : super(key:key) {
    // todo: remove this (and in router) if we don't use it.
    fromCollectible = collectibles[0];
  }

  late final CollectibleData? fromCollectible;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Hero(
        tag: 'collectible_image',
        child: CachedNetworkImage(
          imageUrl: fromCollectible!.imageUrl,
          width: 80,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        color: context.colors.accent1,
        padding: EdgeInsets.all(8.0),
        child: Text("COLLECTION, found ${fromCollectible?.title ?? 'nothing'}"),
      )
    ]));
  }

}