import 'package:flutter/material.dart';
import 'package:minihackathon/Animation/Animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minihackathon/polls/Pollresults.dart';
import 'package:minihackathon/postpage.dart';

class Pollcreater extends StatefulWidget {
  static final id = "sign up";
  @override
  _PollcreaterState createState() => _PollcreaterState();
}

class _PollcreaterState extends State<Pollcreater> {
  String poll, time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                                  poll = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        "Poll question Ex:Will you be able to come for lunch?",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          onPressed: () {
                            if (poll != null) {
                              updatePoll(poll);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        content: new Text(
                                          "Poll question cannot be empty",
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
                          },
                          child: Text(
                            "Create Poll",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          onPressed: () {
                            Navigator.pushNamed(context, pollresults.id);
                          },
                          child: Text(
                            "View poll results",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Row(children: [
                      SizedBox(width: 220),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, postpage.id);
                        },
                        child: Text("Post"),
                      ),
                    ]),
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

Future<void> updatePoll(String question) async {
  String user = FirebaseAuth.instance.currentUser.email.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('polls');
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('polls').doc("Abcde");
  return users
      .doc('Abcde')
      .set({
        "question": question,
        "option 1 voted": 0,
        "option 2 voted": 0,
        "id": "Abcde",
        "creater": user,
        "uservoted": {user: 1},
      })
      .then((value) => print("email is  $user"))
      .catchError((error) => print("Failed to add user: $error"));
}
