import 'package:animations/scroll_behavior.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      // debugShowMaterialGrid: true,
      scrollBehavior: ScrollBehaviour(),
      theme: ThemeData.dark(),
      home: const App(),
    ),
  );
}