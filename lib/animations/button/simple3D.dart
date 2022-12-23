import 'package:flutter/material.dart';

class Simple3DButton extends StatefulWidget {
  final String title;
  final void Function()? onTap;

  const Simple3DButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  State<Simple3DButton> createState() => _Simple3DButtonState();
}

class _Simple3DButtonState extends State<Simple3DButton> {
  final double shadowHeight = 4;
  double position = 4;

  @override
  Widget build(BuildContext context) {
    final double height = 64 - shadowHeight;
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          position = 4;
        });
      },
      onTapDown: (_) {
        setState(() {
          position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          position = 4;
        });
      },
      onTap: widget.onTap,
      child: SizedBox(
        height: height + shadowHeight,
        width: 200,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: position,
              duration: const Duration(milliseconds: 70),
              child: Container(
                height: height,
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purpleAccent,
                      Colors.deepPurple.shade800,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
