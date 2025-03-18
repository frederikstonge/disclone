import 'package:disclone/router/router.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    );
    return MaterialApp.router(
      builder:
          (context, child) => ResponsiveBreakpoints(
            breakpoints: [
              Breakpoint(start: 0, end: 600, name: 'SHRINK'),
              Breakpoint(start: 601, end: double.infinity, name: 'SPLIT_SCREEN'),
            ],
            child: child!,
          ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: colorScheme.surfaceContainerHigh,
        brightness: Brightness.dark,
        colorScheme: colorScheme,
      ),
      routerConfig: router,
    );
  }
}
