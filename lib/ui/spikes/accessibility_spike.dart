import 'package:wonders/common_libs.dart';

class AccessibilitySpike extends StatelessWidget {
  const AccessibilitySpike({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            //child: _AutoReadAndBasicText(),
            //child: _HeadersAndAutoRead(),
            child: _ScrollingAndLists(),
          ),
        ],
      ),
    );
  }
}

class _AutoReadAndBasicText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),
        Semantics(
          header: true,
          child: Column(
            children: const [
              Text('Title'),
              Text('This is some content that should be auto-read'),
            ],
          ),
        ),
        Text('This should not be auto-read'),
      ],
    );
  }
}

class _HeadersAndAutoRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Q: Does Header get read before other live regions
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          header: true,
          child: Text('Heading 1'),
        ),
        Semantics(
          header: true,
          child: Text('Heading 2'),
        ),
      ],
    );
  }
}

class _ScrollingAndLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Q: How to get sound effect when paging/scrolling, as shown in the native Android Screen Reader demo
    // return ListView(
    //   children: List.generate(
    //       20,
    //       (index) => ListTile(
    //             title: Text('Item $index'),
    //           )),
    // );
    return PageView(
      scrollDirection: Axis.vertical,
      children: List.generate(
          20,
          (index) => ListTile(
                title: Center(child: Text('Item $index')),
              )),
    );
  }
}
