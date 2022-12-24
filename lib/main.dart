import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      // debugShowMaterialGrid: true,
      theme: ThemeData.dark(),
      home: const App(),
    ),
  );
}
