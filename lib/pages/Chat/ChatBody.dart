





import 'package:chatk/pages/Chat/ChatScreen.dart';
import 'package:flutter/material.dart';

import '../../model/User.dart';

class ChatBody extends StatelessWidget{

  late final List<UserModel> users;

  @override
  Widget build(BuildContext context) =>Expanded(
      child:Container(

        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(topRight: Radius.circular(25),
          topLeft: Radius.circular(25)),
        ),
        child: buildChats(),
      )
  );
Widget buildChats() =>
    ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final user = users[index];
        return Container(
          height: 75,
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ));
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.image??""),
            ),
            title: Text(user.name??""),
          ),
        );
      },
      itemCount: users.length,
    );



}
