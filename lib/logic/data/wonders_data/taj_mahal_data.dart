import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/mock_data.dart';

final tajMahalData = WonderData(
  type: WonderType.tajMahal,
  title: 'Taj Mahal',
  subTitle: 'subtitle goes here',
  regionTitle: 'TODO',
  videoId: 'zJCrrTk-dLQ',
  startYr: 550,
  endYr: 1550,
  lng: 20.68346184201756,
  lat: -88.56769676930931,
  imageIds: mockImageIds,
  unsplashCollectionId: 'BIZuSm1fmiw',
  quote1: 'Coming soon...',
  quote2: 'Coming soon',
  historyInfo1: lorem(paragraphs: 1, words: 60),
  historyInfo2: lorem(paragraphs: 1, words: 60),
  constructionInfo1: lorem(paragraphs: 1, words: 60),
  constructionInfo2: lorem(paragraphs: 1, words: 60),
  locationInfo: lorem(paragraphs: 1, words: 60),
  highlightArtifacts: const [
    '',
    '',
    '',
    '',
    '',
    '',
  ],
);
