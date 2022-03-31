import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/cards/opening_card.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({Key? key, this.child, this.padding}) : super(key: key);
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.grey.shade600.withOpacity(.3))),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              child: child ?? SizedBox.shrink(),
              padding: padding ?? EdgeInsets.all(context.insets.md),
            ),
          )
        ],
      ),
    );
  }
}

class OpeningGlassCard extends StatelessWidget {
  const OpeningGlassCard({
    Key? key,
    required this.closedBuilder,
    required this.openBuilder,
    required this.isOpen,
    this.padding,
  }) : super(key: key);

  final Widget Function(BuildContext) closedBuilder;
  final Widget Function(BuildContext) openBuilder;
  final bool isOpen;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => OpeningCard(
      padding: padding,
      isOpen: isOpen,
      openBuilder: openBuilder,
      closedBuilder: closedBuilder,
      background: GlassCard());
}
