import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double height = 150;
  double width = 150;
  Color color = Colors.purpleAccent;
  BorderRadius borderRadius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          height: height,
          width: width,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInToLinear,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.withOpacity(0.5),
        onPressed: (){
          setState(() {
            width = width == 150 ? 300 : 150;
            height = height == 150 ? 300 : 150;
            color = color == Colors.purpleAccent ? Colors.deepPurple.shade600 : Colors.purpleAccent;
            borderRadius = borderRadius == BorderRadius.circular(10) ? BorderRadius.circular(30) : BorderRadius.circular(10);
          });

        },
        child: Icon(Icons.touch_app, size: 30, color: color),
      ),
    );
  }
}
