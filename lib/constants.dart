import 'package:flutter/material.dart';
String hntText="s";
String hntTextPass="";
String finderEmail="";
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const kMessageTextFieldDecoration=
   InputDecoration(
contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
hintText: "Enter Email",
border: InputBorder.none,
);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
//Constant for Decoration Widget
const double kVertical=10;
const double kHorizontal=20;
const double  kCRadius=32.0;
const double kFocusedWidth=2.0;
const  double kUnFocusedWidth=1.0;
const KTextFieldDecoration=InputDecoration(
  hintText:'Enter your message here.',
  contentPadding:
  EdgeInsets.symmetric(vertical:kVertical, horizontal: kHorizontal),
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
);
String email="";
String pass="";


