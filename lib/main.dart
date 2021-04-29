import 'package:chatwith/LoginStates.dart';
import 'package:chatwith/constants.dart';
import 'package:chatwith/screens/ContactScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatwith/screens/welcome_screen.dart';
import 'package:chatwith/screens/login_screen.dart';
import 'package:chatwith/screens/registration_screen.dart';
import 'package:chatwith/screens/chat_screen.dart';
String initialRoute=WelcomeScreen.id;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await readState();
   if(loginState=="logIn") {
     email=em;
     pass=ps;
     FirebaseAuth _auth = FirebaseAuth.instance;
     try {
       await _auth.signInWithEmailAndPassword(email: em, password: ps);
       initialRoute=ContactScreen.id;
     }
     catch (e) {
       print(e);
     }
   }
 runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute:initialRoute,
      routes: {
        ContactScreen.id:(context)=>ContactScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
         LoginScreen.id:(context)=>LoginScreen(),
       RegistrationScreen.id:(context)=>RegistrationScreen(),
         ChatScreen.id:(context)=>ChatScreen(),
    },
    );
  }
}
