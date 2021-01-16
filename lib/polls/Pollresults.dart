import 'package:flutter/material.dart';
import 'package:minihackathon/Animation/Animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pollcreater.dart';

class pollresults extends StatefulWidget {
static final id="pollresults";
  @override
  _pollresultsState createState() => _pollresultsState();
}

class _pollresultsState extends State<pollresults> {
  String yes = "2", no = "3";
  void getResults() async {
    await for (var snapshots
        in FirebaseFirestore.instance.collection("polls").snapshots()) {
      for (var poll in snapshots.docs) {
        setState(() {
          yes = poll.data()["option 1 voted"].toString();
          no = poll.data()["option 2 voted"].toString();
        });
      }
    }
  }

  _pollresultsState() {
    getResults();
  }
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
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Poll results",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
                        child: Row(
                        children:[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: studentlist(yes: "$yes Students",come: "will come",),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: studentlist(yes: "$no Students",come: "won't come now",),
                            ),],
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
                          onPressed: () async{
                           await updatePoll();
                            Navigator.pushNamed(context,Pollcreater.id);
                          },
                          child: Text(
                            "Delete Poll",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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

class studentlist extends StatelessWidget {
  studentlist({this.yes,this.come
  });

  String yes,come;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(yes,
          style: TextStyle(
              color:
                  Color.fromRGBO(143, 148, 251, 1),
                  fontSize:25.0,)),
                  Text(come,
          style: TextStyle(
              color:
                  Color.fromRGBO(143, 148, 251, 1),
                  fontSize:15.0,)),
    ]);
  }
}
Future<void> updatePoll() async {
  CollectionReference users = FirebaseFirestore.instance.collection('polls');
  DocumentReference documentReference = FirebaseFirestore.instance
  .collection('polls')
  .doc("Abcde");
 return users
    .doc('Abcde')
    .set({
    "option 1 voted":0,
    "option 2 voted":0,
    "id":"Abcde",
    "question":"Poll is not created right now",
    "creater":"noreply@gmaail.com",
    "uservoted":{"noreply@gmaail.com":0},
    })
    .then((value) => print("User Added"));
}
