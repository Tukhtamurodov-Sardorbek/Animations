import 'package:animations/animations/button/simple3D.dart';
import 'package:animations/animations/rive/sign_in.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Simple3DButton(title: 'Teddy Sign In', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SignInPage()));
            }),
          ],
        ),
      ),
    );
  }
}