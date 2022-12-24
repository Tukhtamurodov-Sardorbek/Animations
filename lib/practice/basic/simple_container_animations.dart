import 'package:flutter/material.dart';

class SimpleContainerAnimations extends StatefulWidget {
  const SimpleContainerAnimations({Key? key}) : super(key: key);

  @override
  State<SimpleContainerAnimations> createState() =>
      _SimpleContainerAnimationsState();
}

class _SimpleContainerAnimationsState extends State<SimpleContainerAnimations> with TickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController animatedIconController;
  late AnimationController containerAnimationController;
  late Animation iconColorAnimation;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  late Animation borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    // * Controllers
    animatedIconController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    containerAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    // * Animations
    iconColorAnimation = ColorTween(begin: Colors.deepPurple.shade600, end: Colors.purpleAccent).animate(animatedIconController);
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
            animatedIconController.forward();
            containerAnimationController.forward();
          } else {
            animatedIconController.reverse();
            containerAnimationController.reverse();
          }
        },
        child: AnimatedIcon(
          size: 30,
          icon: AnimatedIcons.play_pause,
          progress: animatedIconController,
          color: iconColorAnimation.value,
        ),
      ),
    );
  }
}
