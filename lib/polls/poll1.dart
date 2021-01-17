
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:minihackathon/Animation/Animation.dart';

class Poll extends StatefulWidget {
  static final id="Poll";
  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<Poll> {
  double option1 = 0;
  double option2 = 0;
  String user = FirebaseAuth.instance.currentUser==null?FirebaseAuth.instance.currentUser.email.toString():"sethu@gmail.com";
  String question="k";
  Map usersWhoVoted = {'sam@mail.com': 1};
  String creator = "eddy@mail.com";
  var id1;
  void getqs() async {
    print(FirebaseAuth.instance.currentUser.email);
    await for (var snapshots
        in FirebaseFirestore.instance.collection("polls").snapshots()) {
      for (var poll in snapshots.docs) {
        setState(() {
          question=poll.data()["question"];
          option1 = poll.data()["option 1 voted"].toDouble();
          option2 = poll.data()["option 2 voted"].toDouble();
          creator = poll.data()["creater"];
          id1=poll.data()["id"];
          usersWhoVoted=(poll.data()["uservoted"]);
        });
      }
    }
  }
  _PollViewState(){
  getqs();
}

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar( 
      title:Row(
        mainAxisAlignment:MainAxisAlignment.end,
        children:[
          GestureDetector(child: Icon(
            Icons.logout,
          ),
          onTap: (){
            FirebaseAuth.instance.signOut();
          },)

        ],
      ),),
      body: Container(
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
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
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
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
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
            FadeAnimation(1.7,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:40.0),
                child: Polls(
                  children: [
                    Polls.options(title: "Yes, I will", value: option1),
                    Polls.options(title:"No,I won't", value: option2),
                  ],
                  question: Text(question,style:TextStyle(
                     color: Color.fromRGBO(143, 148, 251, 1),
                  )),
                  currentUser:user,
                  creatorID: creator,
                  voteData: usersWhoVoted,
                  userChoice: usersWhoVoted[user],
                  onVoteBackgroundColor: Colors.deepPurpleAccent,
                  leadingBackgroundColor: Colors.purpleAccent,
                  backgroundColor: Colors.blueGrey[200],
                  onVote: (choice) {
                    setState(() {
                      usersWhoVoted[user] = choice;
                      print(usersWhoVoted);
                    });
                    if (choice == 1) {
                      updatePoll(id1,"option 1 voted",option1+1,usersWhoVoted);
                      setState(() {
                        option1 += 1.0;
                      });
                    }
                    if (choice == 2) {
                      updatePoll(id1,"option 2 voted",option2+1,usersWhoVoted);
                      setState(() {
                        option2 += 1.0;
                      });
                    }
                  },
                ), 
              ),
            ),
          ],
        ),
      ),
    );}}
    

Future<void> updatePoll(id,option,value,Map user) {
  CollectionReference users = FirebaseFirestore.instance.collection('polls');
  return users
    .doc(id)
    .update({"$option":value.toInt(),
    "uservoted":user})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
    
}
