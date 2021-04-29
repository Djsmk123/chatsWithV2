import 'package:chatwith/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatwith/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../LoginStates.dart';
final _firestore=FirebaseFirestore.instance;
late String msgEmail;
late String msgMessage;
late String msgRec;
final messageTextController=TextEditingController();
final _auth=FirebaseAuth.instance;
late User loggedInUser;
late String messageText;
class ChatScreen extends StatefulWidget {
  static String id='ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {

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
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout,
              ),
              onPressed: ()
            {
            _auth.signOut();
            Navigator.pushNamed(context, WelcomeScreen.id);
            em=email="";
            ps=pass=" ";
            loginState="NotLogIN";
            writeState();
             }
              ),
        ],
        title: Row( children:<Widget>[
          Container(
            child: Image.asset('images/logo.png'),
            height:30.0,
          ),
          Text('️Chats'),
        ],
        ),
        backgroundColor:Color(0xFF0C143E),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                       messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('chats').add({
                        'text':messageText,
                        'sender':loggedInUser.email,
                        'Receiver':finderEmail.toString(),
                        'Time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Icon(Icons.send)
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender,required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
     String idSendRec;
    if(isMe==true)
       idSendRec="Me" ;
    else
      idSendRec=sender;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
             idSendRec,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.greenAccent,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ?  Color(0xFF0C143E) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ignore: must_be_immutable
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').orderBy('Time',descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
            List<MessageBubble> messageBubbles = [];
           messageBubbles.removeRange(0,messageBubbles.length);
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            for (var msgC in documents) {
              msgEmail = msgC['sender'];
              msgMessage =msgC['text'];
              msgRec = msgC['Receiver'];
              final currentUser = loggedInUser.email;
              final messageBubble = MessageBubble(
                  sender: msgEmail,
                  text: msgMessage,
                  isMe: currentUser == msgEmail);
              if (msgEmail == currentUser && msgRec==finderEmail)
              messageBubbles.add(messageBubble);
              else if(msgEmail==finderEmail && msgRec==currentUser)
               messageBubbles.add(messageBubble);
            }
          return Expanded( 
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
    );
  }
}