import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'components/teddy_controller.dart';
import 'components/trackable_text_input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TeddyController teddyController;
  String email = '';
  String password = '';
  bool isLoading = false;
  bool isObscured = true;

  @override
  void initState() {
    teddyController = TeddyController();
    super.initState();
  }

  void onPressed() async {
    if (email.isEmpty && password.isEmpty) {
      _showSnackBar('Please Enter Valid Information');
      teddyController.play('fail');
    } else {
      if (_isEmailValid(email)) {
        isLoading = true;
        setState(() {});
        await Future.delayed(const Duration(seconds: 5));
        teddyController.play("success");
        _showSnackBar('Sign in succeeded...');
        isLoading = false;
        setState(() {});
      } else {
        teddyController.play('fail');
        _showSnackBar('Please Enter Valid Email Address');
      }
    }
  }

  bool _isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _showSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(title, textAlign: TextAlign.center)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purpleAccent,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 90),
            SizedBox(
              height: height * 0.25,
              child: FlareActor(
                'assets/teddy/Teddy.flr',
                shouldClip: false,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                controller: teddyController,
              ),
            ),
            Container(
              height: height * 0.45,
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TrackingTextInput(
                      onTextChanged: (String email) {
                        email = email;
                      },
                      label: "Email",
                      onCaretMoved: (Offset caret) {
                        teddyController.coverEyes(false);
                        teddyController.lookAt(caret);
                      },
                      icon: Icons.email,
                      enable: !isLoading,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: TrackingTextInput(
                            label: "Password",
                            isObscured: isObscured,
                            onCaretMoved: (Offset caret) {
                              teddyController.coverEyes(true);
                              teddyController.lookAt(null);
                            },
                            onTextChanged: (String password) {
                              password = password;
                            },
                            icon: Icons.lock,
                            enable: !isLoading,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              isObscured ? Icons.visibility : Icons.visibility_off,
                              color: Colors.deepPurple.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 8)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.deepPurple.shade600),
                      ),
                      child: isLoading
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 25.0,
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
