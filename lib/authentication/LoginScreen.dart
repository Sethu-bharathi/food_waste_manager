import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minihackathon/Animation/Animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minihackathon/polls/poll1.dart';
import 'package:minihackathon/polls/pollcreater.dart';

class LoginScreen extends StatelessWidget {
  static final id = "Log in";
  static bool _isStudent;
  String email, password;
  Future<void> isStudent(String _email) async {
    await for (var snapshots in FirebaseFirestore.instance
        .collection("authentication")
        .snapshots()) {
      for (var student in snapshots.docs) {
        if (_email == student.data()["email"]) {
          if (student.data()["is student"] == true) {
            _isStudent = true;
            return true;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                        child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: MaterialButton(
                          onPressed: () async {
                            Login(email, password);
                            await isStudent(email);
                            if (_isStudent == true) {
                              Navigator.pushNamed(context, Poll.id);
                            } else {
                              Navigator.pushNamed(context, Pollcreater.id);
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                        1.5,
                        MaterialButton(
                          onPressed: () async {
                            try {
                              if (email != null) {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email)
                                    .then((value) => showDialog(
                                        context: context,
                                        builder: (_) => new AlertDialog(
                                              content: new Text(
                                                "Password reset link sent to your email",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        143, 148, 251, 1)),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            143, 148, 251, 1)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            )));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                          content: new Text(
                                            "emai cannot be empty",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        143, 148, 251, 1)),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void Login(String email, String password) async {
  final _auth = FirebaseAuth.instance;
  try {
    final newUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  } catch (e) {
    print(e);
  }
}
