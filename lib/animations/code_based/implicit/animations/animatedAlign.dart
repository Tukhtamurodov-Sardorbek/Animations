import 'package:flutter/material.dart';

class AnimatedAlignPage extends StatefulWidget {
  const AnimatedAlignPage({Key? key}) : super(key: key);

  @override
  State<AnimatedAlignPage> createState() => _AnimatedAlignPageState();
}

class _AnimatedAlignPageState extends State<AnimatedAlignPage> {
  AlignmentGeometry alignment1 = Alignment.topRight;
  AlignmentGeometry alignment2 = Alignment.bottomLeft;
  AlignmentGeometry alignment3 = Alignment.topLeft;
  AlignmentGeometry alignment4 = Alignment.bottomRight;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: alignment1,
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 2),
                child: const Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: Colors.purpleAccent,
                ),
              ),
              AnimatedAlign(
                alignment: alignment2,
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 2),
                child: Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: Colors.deepPurple.shade600,
                ),
              ),

              const Positioned.fill(
               child: Center(
                 child: Icon(
                   Icons.circle,
                   size: 30,
                   color: Colors.white70,
                 ),
               ),
              ),

              AnimatedAlign(
                alignment: alignment3,
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 2),
                child: const Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: Colors.purpleAccent,
                ),
              ),
              AnimatedAlign(
                alignment: alignment4,
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 2),
                child: Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: Colors.deepPurple.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade600,
        onPressed: (){
          setState(() {
            alignment1 = alignment1 == Alignment.topRight
                ? Alignment.bottomLeft
                : Alignment.topRight;
            alignment2 = alignment1 == Alignment.topRight
                ? Alignment.bottomLeft
                : Alignment.topRight;

            alignment3 = alignment3 == Alignment.topLeft
                ? Alignment.bottomRight
                : Alignment.topLeft;
            alignment4 = alignment3 == Alignment.topLeft
                ? Alignment.bottomRight
                : Alignment.topLeft;
          });
        },
        child: const Icon(Icons.touch_app, size: 30, color: Colors.purpleAccent),
      ),
    );
  }
}
