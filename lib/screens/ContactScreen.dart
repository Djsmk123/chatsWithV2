
import 'package:chatwith/LoginStates.dart';
import 'package:chatwith/screens/chat_screen.dart';
import 'package:chatwith/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
class ContactScreen extends StatefulWidget {
  static String id='Contact_Screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}
String contactEmail="";
late User loggedInUser;
var contactsDetails=new Map();
late String loginUseremail="";
final _firestore=FirebaseFirestore.instance;
final _auth=FirebaseAuth.instance;
class _ContactScreenState extends State<ContactScreen> {
  String errorAddContact="";
  int existContact=0;
  late String deleteContact;
  @override
   void initState() {
     super.initState();
     getCurrentUser();
   }
  void getCurrentUser() async
  {
    final user=_auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        loginUseremail=loggedInUser.email!;
      }
    }
    catch(e)
    {
      print(e);
    }
  }
   Future<void> writeData()
   async {
    _firestore.collection('$loginUseremail').add(
        {
          'email': contactEmail
        }
    );
  }
  Future<void> callDialog()
  async {
    showDialog<void>(
      context: context,
      builder: (c) =>
          AlertDialog(
            title: Text('Warning',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(errorAddContact,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Center(child:
              TextButton(
                child: Text('okay',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                ),
                onPressed: () => Navigator.pop(c, false),
              ),
              ),
            ],
          ),
    );
  }
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: ()  {
      showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning',
            style: TextStyle(
              color:Colors.red,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Do you really want to back?\nYou will logout.',
            style: TextStyle(
              color:Colors.lightBlueAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              child: Text('Yes',
                style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.blueAccent,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreen.id);
                em=email="";
                ps=pass=" ";
                loginState="NotLogIN";
                writeState();
              }
            ),
            TextButton(
              child: Text('No',
            style: TextStyle(
               fontSize: 15.0,
                color:Colors.blueAccent,
                ),
              ),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      );
      return Future.value(false);
    },
    child:Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: Text('️Friends'),
        backgroundColor:Color(0xFF0C143E),
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.message_outlined),
        backgroundColor: Colors.indigoAccent,
        onPressed: (){
          messageTextController.clear();
          setState(() {
            print(contactsDetails);
            if(contactEmail==loginUseremail) {
              errorAddContact="Cannot add yourself as friend";
              callDialog();
            }
            else if(contactsDetails[contactEmail]!=null)
              {
                errorAddContact="Already exist in your friends list";
                callDialog();
              }
            else
            writeData();
          });
        }
      ), floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children:<Widget> [
      TextField(
            keyboardType: TextInputType.emailAddress,
          controller: messageTextController,
            textAlign: TextAlign.center,
              onChanged: (value)
              {
                contactEmail=value;
              },
            decoration:InputDecoration(
              hintText:'Enter email of your friend',
              contentPadding: EdgeInsets.symmetric(vertical:kVertical, horizontal: kHorizontal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kCRadius)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: kUnFocusedWidth),
                borderRadius: BorderRadius.all(Radius.circular(kCRadius)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.lightBlueAccent, width: kFocusedWidth),
                borderRadius: BorderRadius.all(Radius.circular(kCRadius)),
              ),
            )
          ),
         ContactListStream(),
        ],
      ),
    ),
    );
  }
}
// ignore: camel_case_types
class contactsViews extends StatelessWidget {
  contactsViews({required this.addEmail});
  final String addEmail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children:<Widget>[
          MaterialButton(onPressed: () {
            Navigator.pushNamed(context, ChatScreen.id);
            finderEmail=addEmail;
          },
            onLongPress: (){
            showDialog<void>(
            context: context,
            builder: (c) => AlertDialog(
            title: Text('Warning',
            style: TextStyle(
            color:Colors.red,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            ),
            ),
            content: Text('Do you want to delete?',
            style: TextStyle(
            color:Colors.cyan,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            ),
            ),
            actions: [
            TextButton(
            child: Text('Yes',
            style: TextStyle(
            fontSize: 15.0,
            color:Colors.red,
            ),
            ),
            onPressed: () async {
              var tmp=contactsDetails[addEmail];
              _firestore.collection('$loginUseremail').doc('$tmp').delete();
              Navigator.pop(c, false);
            }
            ),
            TextButton(
            child: Text('No',
            style: TextStyle(
            fontSize: 15.0,
            color:Colors.red,
            ),
            ),
            onPressed: () {
            Navigator.pop(c, false);
            }
            ),
            ],
            ),
            );
            },
            child:   Text(
              addEmail,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.greenAccent,
              ),
            ),
          ),
             ],
          ),
        ],
      ),
    );
  }
}


class ContactListStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('$loginUseremail').snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center(
    child: CircularProgressIndicator(
    backgroundColor: Colors.lightBlueAccent,
    ),
    );
    }
    final List<QueryDocumentSnapshot> contacts = snapshot.data!.docs;
    List<contactsViews>contactsView=[];
     String contactStr;
     contactsDetails=new Map();
    for(var i in contacts)
    {
     contactStr=i['email'];
     contactsDetails['$contactStr']=i.id;
    final tempContactView =contactsViews(addEmail:contactStr);
    contactsView.add(tempContactView);
    }
    return Expanded(
    child: ListView(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    children: contactsView,
    ),
    );
    }
    );
  }
}


