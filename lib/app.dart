import 'package:animations/animations/buttons/buttons.dart';
import 'package:animations/animations/rive/sign_in.dart';
import 'package:animations/practice/basic/simple_container_animations.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              HorizontalScrollView(
                header: 'Practices',
                children: [
                  Button(
                    title: 'Container Animations',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SimpleContainerAnimations()));
                    },
                  ),
              ],
          ),
              HorizontalScrollView(
                header: 'Animations',
                children: [
                  Button(
                    title: 'Button Animations',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const ButtonsPage()));
                    }
                  ),
              ],
          ),
              HorizontalScrollView(
                header: 'Rive Animations',
                children: [
                  Button(
                    title: 'Teddy Sign In',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SignInPage()));
                    },
                 ),
              ],
          ),
            ],
          ),
        ),
    );
  }

  Widget Button({required String title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          backgroundColor: Colors.deepPurple.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(title),
      ),
    );
  }
}

class HorizontalScrollView extends StatelessWidget {
  final String header;
  final List<Widget> children;

  const HorizontalScrollView({Key? key, required this.header, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.deepPurple.shade600,
            alignment: Alignment.center,
            child: Text(
              header,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: children,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
