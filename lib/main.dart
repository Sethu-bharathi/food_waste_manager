import 'package:flutter/material.dart';
import 'package:minihackathon/authentication/LoginScreen.dart';
import 'package:minihackathon/authentication/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minihackathon/polls/poll1.dart';
import 'package:minihackathon/polls/pollcreater.dart';
import 'package:minihackathon/polls/pollresults.dart';
import 'package:minihackathon/postpage.dart';
import 'package:minihackathon/waitpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    
  String getuser() {
    final _auth=FirebaseAuth.instance;
    if(_auth.currentUser==null){
      return Signup.id;
  }
    return Waitpage.id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Signup(),
      initialRoute:getuser(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        Signup.id: (context) => Signup(),
        Poll.id: (context) => Poll(),
        Pollcreater.id: (context) => Pollcreater(),
        pollresults.id: (context) => pollresults(),
        Waitpage.id:(context)=>Waitpage(),
        postpage.id:(context)=>postpage(),
      },
    );
  }
}
