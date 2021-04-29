import 'package:chatwith/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatwith/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
String errorReg="";
class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  bool  showSpinner=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      errorReg="Note:Password should be at least 8 characters.";
    });
  }
  @override
  Widget build(BuildContext context) {
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
            Hero(tag:'logo' , child:
            Container(
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
                color:Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed:()async {
                    setState(() {
                      showSpinner=true;
                    });
                    var codeError;
                    try {
                        await _auth.createUserWithEmailAndPassword(email: email, password: pass).catchError((e) => codeError=e.message);
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      setState(()
                      {
                        showSpinner=false;
                      });
                    }
                    catch (e) {
                      if(codeError=="The email address is already in use by another account.")
                        {
                          setState(() {
                            showSpinner=false;
                            errorReg="The email address is already in use by another account.";
                          });
                        }
                        if (codeError == "Given String is empty or null.") {
                        setState(() {
                          showSpinner = false;
                          errorReg = "Email or password is empty.";
                        });
                      }
                      if (codeError == "The email address is badly formatted.") {
                        setState(() {
                          showSpinner = false;
                          errorReg = "Enter a valid email address.";
                        });
                      }
                      else {
                        if (codeError == "Given String is empty or null") {
                          setState(() {
                            showSpinner = false;
                            errorReg = "Password can not be empty.";
                          });
                        }
                      }
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
            Text(
              errorReg,
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
