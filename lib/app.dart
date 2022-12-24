import 'package:animations/animations/buttons/buttons.dart';
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
            Button(title: 'Button Animations', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const ButtonsPage()));
            }),
            Button(title: 'Teddy Sign In', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SignInPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget Button({required String title, void Function()? onTap}){
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.deepPurple.shade600,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(title),
      ),
    );
  }
}