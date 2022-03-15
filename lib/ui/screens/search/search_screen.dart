import 'package:flutter/cupertino.dart';
import 'package:wonders/common_libs.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class SearchScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with GetItStateMixin {
  final _pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    /// Collect children for the various layers
    return Column(children: [
      CupertinoSearchTextField(),
      Row(children: [
        TextField(),
        Row(children: [Checkbox(value: false, onChanged: (active) => {})])
      ])
    ]);
  }
}
