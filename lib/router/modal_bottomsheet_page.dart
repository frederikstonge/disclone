import 'package:flutter/material.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  final Widget child;
  final bool showDragHandle;

  const ModalBottomSheetPage({
    super.key,
    required this.child,
    this.showDragHandle = false,
  });

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        clipBehavior: Clip.antiAlias,
        settings: this,
        showDragHandle: false,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) => child,
      );
}
