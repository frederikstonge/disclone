import 'package:flutter/material.dart';

class AnimationlessPage<T> extends Page<T> {
  final Widget child;

  const AnimationlessPage({required this.child});
  
  
  @override
  Route<T> createRoute(BuildContext context) => _NoAnimationMaterialPageRoute<T>(
    settings: this,
    builder: (context) => child,
  );
}

class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
