import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SplitScreenLayoutView extends StatelessWidget {
  final Function(BuildContext context, bool isSplitScreen) builder;
  final Function(BuildContext context, bool isSplitScreen) optionalBuilder;
  final double sidebarWidth;

  const SplitScreenLayoutView({
    super.key,
    required this.builder,
    required this.optionalBuilder,
    this.sidebarWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    final isSplitScreen = ResponsiveBreakpoints.of(context).breakpoint.name != 'SHRINK';
    if (!isSplitScreen) {
      return builder(context, isSplitScreen);
    }

    return Row(
      children: [
        SizedBox.fromSize(size: Size.fromWidth(sidebarWidth), child: builder(context, isSplitScreen)),
        Expanded(child: optionalBuilder(context, isSplitScreen)),
      ],
    );
  }
}
