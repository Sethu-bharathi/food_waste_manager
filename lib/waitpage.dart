import 'package:flutter/material.dart';
import 'package:minihackathon/authentication/LoginScreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minihackathon/authentication/signup.dart';
import 'package:minihackathon/polls/poll1.dart';
import 'package:minihackathon/polls/pollcreater.dart';
import 'dart:async';

class Waitpage extends StatefulWidget {
  static final id = "Wait page";
  @override
  _WaitpageState createState() => _WaitpageState();
}

class _WaitpageState extends State<Waitpage> {
  static bool _isStudent;
  static String homepage = Signup.id;

  Future<void> isStudent(String _email) async {
    try {
      await for (var snapshots in FirebaseFirestore.instance
          .collection("authentication")
          .snapshots()) {
        for (var student in snapshots.docs) {
          if (_email == student.data()["email"]) {
            if (student.data()["is student"] == true) {
              _isStudent = true;

              return true;
            } else {
              _isStudent = false;
            }
          }
        }
        _isStudent = false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getuser() async {
    final _auth = FirebaseAuth.instance;
    isStudent(_auth.currentUser.email.toString());
    if (_isStudent == false) {
      Navigator.pushNamed(context, Pollcreater.id);
    } else {
      Navigator.pushNamed(context, Poll.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000), () async {
      await getuser();
    });
    return Scaffold(
      body: Container(
          child: Center(
        child: SplashScreen(
          seconds: 3,
          title: Text(
            'Food waste manager',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.blueGrey),
          ),
        ),
      )),
    );
  }
}
