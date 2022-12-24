import 'package:animations/animations/code_based/implicit/animations/animatedAlign.dart';
import 'package:animations/animations/code_based/implicit/animations/animatedCrossFade.dart';
import 'package:animations/animations/code_based/implicit/animations/animatedDefaultTextStyle.dart';
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
      home: const AnimatedDefaultTextStylePage(),
    ),
  );
}