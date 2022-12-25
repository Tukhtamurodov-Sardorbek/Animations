import 'package:flutter/material.dart';

class AnimatedModalBarrierPage extends StatefulWidget {
  const AnimatedModalBarrierPage({Key? key}) : super(key: key);

  @override
  State<AnimatedModalBarrierPage> createState() => _AnimatedModalBarrierPageState();
}

class _AnimatedModalBarrierPageState extends State<AnimatedModalBarrierPage> with SingleTickerProviderStateMixin{
  bool isPressed = false;
  late Widget animatedModalBarrier;
  late AnimationController animationController;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    colorAnimation = ColorTween(begin: Colors.purpleAccent, end: Colors.deepPurple.shade600).animate(animationController);
    animatedModalBarrier = AnimatedModalBarrier(color: colorAnimation, dismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Button is pressed'), duration: Duration(milliseconds: 200),),
                      );

                      isPressed = true;
                      setState(() {});
                      animationController.reset();
                      animationController.forward();
                      Future.delayed(const Duration(seconds: 2), (){
                        isPressed = false;
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    child: const Text('Press', textAlign: TextAlign.center),
                  ),
                  if(isPressed)
                    animatedModalBarrier,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
