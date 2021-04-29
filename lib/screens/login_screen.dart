import 'package:chatwith/LoginStates.dart';
import 'package:chatwith/constants.dart';
import 'package:chatwith/screens/ContactScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  static String id='LogInScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late String errorLogIn="";
  late AnimationController controller;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor:Color(0xFF0C143E),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(child:
            Hero(tag:'logo',child:Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
            ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value)
              {
                email=value;
              },
              decoration:InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: "Enter your email",
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value)
              {
                pass=value;
              },
              decoration:InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: "Enter your password",
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            elevation: 5.0,
            color:Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              onPressed:()async
              { setState(() {
                showSpinner=true;
              });
              var error;
                try{
                 await _auth.signInWithEmailAndPassword(email: email, password: pass).catchError((e) => error=e.message);
                Navigator.pushNamed(context,ContactScreen.id);
                writeState();
                setState(()
                {
                  showSpinner=false;
                });
              }
              catch ( m) {
              if(error=="Given String is empty or null")
                  {
                    setState(() {
                      showSpinner=false;
                      errorLogIn="Field cannot be empty!!!!";
                    });
                  }
              else if(error=="The email address is badly formatted" || error==" There is no user record corresponding to this identifier. The user may have been deleted." || error=="The password is invalid or the user does not have a password.")
                {
                  setState(() {
                    showSpinner=false;
                    errorLogIn="Invalid email or password!! try Again.";
                  });
                }
              print(errorLogIn);
              }
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                'Log IN',
              ),
            ),
          ),
        ),
            Text(
              errorLogIn,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
              ),
            )
        ],
        ),
        ),
        ),
      );

  }
}


