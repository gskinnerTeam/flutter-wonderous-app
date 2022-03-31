import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/buttons.dart';

Future<bool> showModal(BuildContext context, {required Widget child}) async {
  return await showMaterialModalBottomSheet(expand: false, context: context, builder: (_) => child) ?? false;
}

class LoadingModal extends StatelessWidget {
  const LoadingModal({Key? key, this.title, this.msg, this.child}) : super(key: key);
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      child: child,
      buttons: const [],
    );
  }
}

class OkModal extends StatelessWidget {
  const OkModal({Key? key, this.title, this.msg, this.child}) : super(key: key);
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      child: child,
      buttons: [
        AppBtn(child: Text('Ok'), onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}

class OkCancelModal extends StatelessWidget {
  const OkCancelModal({Key? key, this.title, this.msg, this.child}) : super(key: key);
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      child: child,
      buttons: [
        AppBtn(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(false)),
        AppBtn(child: Text('Ok'), onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}

/// Allows for a title, msg and body widget
class _BaseContentModal extends StatelessWidget {
  final String? title;
  final String? msg;
  final Widget? child;
  final List<Widget> buttons;

  const _BaseContentModal({Key? key, this.title, this.msg, required this.buttons, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.insets.lg),
      child: SeparatedColumn(mainAxisSize: MainAxisSize.min, separatorBuilder: () => Gap(context.insets.md), children: [
        if (title != null) Text(title!, style: context.textStyles.h2),
        if (child != null) child!,
        if (msg != null) Text(msg!, style: context.textStyles.body),
        Gap(context.insets.md),
        Row(children: buttons.map((e) => Expanded(child: e)).toList())
      ]),
    );
  }
}
