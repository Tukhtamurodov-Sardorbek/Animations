import 'package:flutter/material.dart';

class SimpleContainerAnimations extends StatefulWidget {
  const SimpleContainerAnimations({Key? key}) : super(key: key);

  @override
  State<SimpleContainerAnimations> createState() =>
      _SimpleContainerAnimationsState();
}

class _SimpleContainerAnimationsState extends State<SimpleContainerAnimations> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  Icon icon = const Icon(Icons.play_arrow, size: 30);

  late AnimationController containerAnimationController;
  late Animation iconColorAnimation;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  late Animation borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    // * Controllers
    containerAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    // * Animations
    colorAnimation = ColorTween(begin: Colors.purpleAccent, end: Colors.deepPurple.shade600).animate(containerAnimationController);
    sizeAnimation = SizeTween(begin: const Size(150, 150), end: const Size(300, 300)).animate(containerAnimationController);
    borderRadiusAnimation = BorderRadiusTween(begin: BorderRadius.circular(10), end: BorderRadius.circular(50)).animate(containerAnimationController);

    // * To rebuild the state
    containerAnimationController.addListener(() {
      setState(() {});
    });

    // * Control animation
    // controller.repeat();
    //controller.forward()
    //controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1200),
              height: isPlaying ? 150 : 300,
              width: isPlaying ? 150 : 300,
              decoration: BoxDecoration(
                color: isPlaying ? Colors.purpleAccent : Colors.deepPurple.shade600,
                borderRadius: isPlaying ? BorderRadius.circular(10) : BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  'Animated Container',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              height: (sizeAnimation.value as Size).height,
              width: (sizeAnimation.value as Size).width,
              decoration: BoxDecoration(
                color: colorAnimation.value,
                borderRadius: borderRadiusAnimation.value,
              ),
              child: const Center(
                child: Text(
                  'Container',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colorAnimation.value,
        onPressed: () {
          isPlaying = !isPlaying;
          if (isPlaying) {
            icon = const Icon(Icons.replay, key: ValueKey(1), size: 30);
            containerAnimationController.forward();
          } else {
            icon = const Icon(Icons.play_arrow, key: ValueKey(2), size: 30);
            containerAnimationController.reverse();
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1200),
          reverseDuration: const Duration(milliseconds: 1200),
          transitionBuilder: (Widget child, Animation<double> animation){
            return RotationTransition(
              turns: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: icon,
        ),
      ),

    );
  }
}
