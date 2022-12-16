import 'package:chatk/model/User.dart';
import 'package:chatk/pages/Chat/ChatScreenBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../core/global/theme/appBarColor/AppColorsDark.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  // User user = User();
  late final List <UserModel> user;
  final _auth = FirebaseAuth.instance;


  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:Colors.grey[900],
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Colors.black12
                    Colors.black54,
                    Colors.black54,
                    Colors.black87,
                    Colors.black87,
                    Colors.black87,
                  ],
                  stops: [ -12, -10, -10, 10, 10],
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.zero)),
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
              ),
              child: Center(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      // final user = user[Index];
                      // final movie = movieProvide.movies!.results![index];
                      return Flexible(
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: ListTile(
                              onTap: () {
                                setState(
                                      () =>
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatScreenBox())),
                                );
                              },
                              title: Row(children: <Widget>[
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage:
                                    AssetImage('images/chat2.jpg'),
                                    radius: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Dalia",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                      height: 5,
                                    ),
                                    Text(
                                      "iam going to market ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50, right: 30),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0),
                                          child: Text(
                                            "now",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0),
                                          child: Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          //                  else {
          // return const CircularProgressIndicator();
          // }

        ));
  }


}