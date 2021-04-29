import 'package:chatwith/screens/login_screen.dart';
import 'package:chatwith/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static String id='Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
   late Animation animation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF0C143E),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: 'logo',
                  child: Container(
                  child: Image.asset('images/logo.png'),
                  height:60.0,
                ),
                ),
        SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 30.0,
              fontFamily: 'Agne',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('ChatsWith'),
              ],
            ),
          ),
        ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
    Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
    elevation: 5.0,
    color:Colors.lightBlueAccent,
    borderRadius: BorderRadius.circular(30.0),
    child: MaterialButton(
    onPressed:(){
      Navigator.pushNamed(context,LoginScreen.id);
    },
    minWidth: 200.0,
    height: 42.0,
    child: Text(
    'Log IN',
    ),
    ),
    ),
    ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color:Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed:(){
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
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

