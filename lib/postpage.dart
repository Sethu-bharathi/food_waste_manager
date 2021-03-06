
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'createblogpost.dart';
import 'crude.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class postpage extends StatefulWidget {
  static final id = "postpage";

  @override
  _postpageState createState() => _postpageState();
}

class _postpageState extends State<postpage> {
  CrudMethods crudMethods = CrudMethods();
  Stream snapshot;
  @override
  void initState() {
    super.initState();
  }

  Widget PostList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context,snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Color.fromRGBO(143, 148, 251, 1)),
            );
          }
          else{
          final posts =snapshot.data.docs;
          List<Widget> postwidgets = [];
          for (var post in posts) {
            postwidgets.add(new PostTile(
              imgurl: post.data()["imgurl"],
              orgname: post.data()["orgname"],
              mobile: post.data()["mobile"],
              descip: post.data()["descript"],
            ));}
            return ListView(
              children: postwidgets,
            );
          }
        },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Food",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            Text(
              " waste",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            Text(
              " manager",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
      body: PostList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateBlogPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  String imgurl, orgname, descip, mobile;
  PostTile(
      {@required this.imgurl,
      @required this.orgname,
      @required this.descip,
      @required this.mobile});
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
                radius: 16.0,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                orgname,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Image.network(
              imgurl,
              fit: BoxFit.cover,
              height: 150,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 20,
              child: Divider(
                indent: 40,
                endIndent: 40,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _makePhoneCall('tel:$mobile');
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.call_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    descip,
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
