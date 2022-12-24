import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedDefaultTextStylePage extends StatefulWidget {
  const AnimatedDefaultTextStylePage({Key? key}) : super(key: key);

  @override
  State<AnimatedDefaultTextStylePage> createState() => _AnimatedDefaultTextStylePageState();
}

class _AnimatedDefaultTextStylePageState extends State<AnimatedDefaultTextStylePage> {
  bool isChanged = false;
  double fontSize = 20;
  FontWeight fontWeight = FontWeight.bold;
  Color color = Colors.purpleAccent;
  TextAlign textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: -math.pi / 3,
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: color, width: 3),
              ),
            ),
            child: AnimatedDefaultTextStyle(
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 1200),
              textAlign: textAlign,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              child: const Text('This is an animated Text Style'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade600,
        onPressed: (){
          isChanged = !isChanged;
          fontSize = isChanged ? 40 : 20;
          fontWeight = isChanged ? FontWeight.w700 : FontWeight.bold;
          color = isChanged ? Colors.deepPurple.shade600 : Colors.purpleAccent;
          textAlign = isChanged ? TextAlign.center : TextAlign.center;
          setState(() {});
        },
        child: const Icon(Icons.touch_app, size: 30, color: Colors.purpleAccent),
      ),
    );
  }
}
