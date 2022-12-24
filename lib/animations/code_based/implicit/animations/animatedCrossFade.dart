import 'package:flutter/material.dart';

class AnimatedCrossFadePage extends StatefulWidget {
  const AnimatedCrossFadePage({Key? key}) : super(key: key);

  @override
  State<AnimatedCrossFadePage> createState() => _AnimatedCrossFadePageState();
}

class _AnimatedCrossFadePageState extends State<AnimatedCrossFadePage> {
  bool showFirstChild = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedCrossFade(
          firstCurve: Curves.easeOutBack,
          secondCurve: Curves.easeInBack,
          sizeCurve: Curves.easeInCubic,

          duration: const Duration(milliseconds: 1200),
          reverseDuration: const Duration(milliseconds: 1200),
          crossFadeState: showFirstChild ? CrossFadeState.showFirst : CrossFadeState.showSecond,

          firstChild: const Center(
            child: Icon(
              Icons.circle_outlined,
              size: 120,
              color: Colors.purpleAccent,
            ),
          ),
          secondChild: Center(
            child: Icon(
              Icons.circle,
              size: 120,
              color: Colors.deepPurple.shade600,
            ),
          ),

          layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                PositionedDirectional(
                  key: bottomChildKey,
                  child: bottomChild,
                ),
                PositionedDirectional(
                  key: topChildKey,
                  child: topChild,
                ),
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade600,
        onPressed: (){
          setState(() {
            showFirstChild = !showFirstChild;
          });
        },
        child: const Icon(Icons.touch_app, size: 30, color: Colors.purpleAccent),
      ),
    );
  }
}
