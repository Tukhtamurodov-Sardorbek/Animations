import 'package:animations/animations/code_based/implicit/animations/animatedList.dart';
import 'package:animations/animations/code_based/implicit/animations/animatedModalBarrier.dart';
import 'package:animations/animations/code_based/scroll_animations/scroll_animations.dart';
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
      home: const TestAnimation(),
    ),
  );
}