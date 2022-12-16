
import 'package:chatk/pages/CallScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:timeago/timeago.dart' as timeago;


final _firestore = FirebaseFirestore.instance;
late User signedInUser ;

class ChatScreenBox extends StatefulWidget {

  @override
  State<ChatScreenBox> createState() => _ChatScreenBox();

}

class _ChatScreenBox extends State<ChatScreenBox> {
  Timestamp? chattime;
  final messageTextController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  final _auth = FirebaseAuth.instance;



  String? messagetext;
  bool show = false;
  bool sendButton = false;

  FocusNode focusNode = FocusNode();

  // void getmessages()
  // async {
  //   final messages = await _firestore .collection('messages').get();
  //   for(var message in messages.docs){
  //   print(message.data());}
  // }

  void messagesStreams()async {
   await for(var snapshot in  _firestore.collection('messages').snapshots()){
     for(var message in snapshot.docs){
       print(message.data());

     }

   }
  }

  @override
  void initState() {

    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Dalia  ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5,
            ),
            Text("online now  ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          IconButton(
              color: Colors.black,
              icon: Icon(
                Icons.call_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen()));

              }),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black12,
                Colors.black26,
                Colors.black45,
                Colors.black54,
              ],
              stops: [-3, -4, -5, 13],
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.zero)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             MessageStreamBuilder(),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.blue, width: 2))),
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    focusNode: focusNode,
                                    controller: messageTextController,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {

                                      messagetext = value;
                                      // if (value.length > 0) {
                                      //   setState(() {
                                      //     sendButton = true;
                                      //   });
                                      // } else {
                                      //   setState(() {
                                      //     sendButton = false;
                                      //   });
                                      // }
                                    },
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: "Type a message",

                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {

                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (builder) =>
//             CameraApp()));
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send  : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      messageTextController.clear();
                                      _firestore.collection("messages").add({
                                        'text': messagetext,
                                        'sender':signedInUser.email,
                                        'senderId':signedInUser.uid,
                                        'time':DateTime.now()
                                      });
                                           if (sendButton) {
                                      _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                      Duration(milliseconds: 300),
                                      curve: Curves.easeOut);


                                      setState(() {
                                      sendButton = false;
                                      });

                                        setState(() {
                                          sendButton = false;
                                        });

                                    }
                                    }

                                  ),
                                ),
                              ),
                            ],
                          ),
// show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
// onWillPop: () {
// if (show) {
// setState(() {
// show = false;
// });
// } else {
// Navigator.pop(context);
// }
// return Future.value(false);
// },
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker2(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            // _controller.text = _controller.text + emoji.emoji;
          });
        });
  }

}

class MessageStreamBuilder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
 return  StreamBuilder<QuerySnapshot>(
     stream:_firestore.collection('messages').where("senderId",isEqualTo:signedInUser.uid).snapshots() ,
     builder:(context,Snapshot){
       List<MessageLine>messagesWidgets = [];

       if(!Snapshot .hasData){
         //spinner
         return Center(
           child: CircularProgressIndicator(
             backgroundColor: Colors.blue,
           ),
         );
       }
       final messages = Snapshot.data!.docs;
       for(var message in messages){
         final messageText = message.get('text');
         final messageSender = message.get('sender');
         final currentyUser = signedInUser.email;
             final  chattime= message.get("time");


         // if(currentyUser == messageSender){
         //   // this code of the message from the signed in user
         // }
         final messageWidget = MessageLine(sender: messageSender,
           text: messageText,
         isMe:currentyUser ==messageSender ,);
         messagesWidgets.add(messageWidget);
       }
       return Expanded(
         child: ListView(
           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
           children: messagesWidgets,
         ),
       );
     }
 );
  }
}
class MessageLine extends StatelessWidget{
const  MessageLine({this.text,this.sender,
  this.image_url,required this.isMe,this.senderId,
this.time,
});

  final String? sender;
  final String? senderId;
  final String? text;
  final String? image_url;
  final DateTime? time;

 final bool isMe;
  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:isMe? CrossAxisAlignment.end :CrossAxisAlignment.start,
            children: [
              // Row(
              //   children:[
              //     Container(
              //       child: CircleAvatar(
              //       backgroundImage:isMe? AssetImage(""):AssetImage("$image_url"),
              //       radius: 20,
              //
              //     ),


                  // ),
                // ],
              // ),
              Material(
                elevation: 5.0,
                borderRadius:isMe? BorderRadius.only(topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30))
                    :BorderRadius.only(topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: isMe ?  Colors.blue :   Colors.grey[500],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                  child: Column(
                    children: [
                      Text("$text ${time}"
                        ,style: TextStyle(fontSize: 12,color:isMe? Colors.white24:Colors.grey)),
                        Text(  timeago.format(time.to()),style: TextStyle(color: Colors.pink[200],)),

                    ],
                  ),
              ),
              )],
          ),
        );

  }

}



//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Expanded(child:
//       Container(
//         padding: EdgeInsets.all(10),
//         child: TextField(
//
//
//           onChanged: (value){
//      },
//
//             decoration: const InputDecoration(
//
//               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)
//               ),),
//               // enabledBorder:OutlineInputBorder(
//               //   borderSide: BorderSide(
//               //     color: Colors.grey,
//               //     width: 1,
//
//                 // ),
//
//                 // borderRadius: BorderRadius.all(Radius.circular(20)
//                 // ),
//
//               // ),
//
//               // labelText: "UserEmail", //babel text
//               hintText: "Type your message",
//               contentPadding:EdgeInsets.symmetric(vertical: 1,horizontal: 5),
//               //hint text
//               prefixIcon: Icon(Icons.emoji_emotions_outlined,),
//                 suffix: Icon(Icons.camera_alt,color: Colors.blue,),
//                 suffixIcon: Icon(Icons.keyboard_voice_outlined,color: Colors.blue,),
//
//
//               hintStyle: TextStyle(
//                   fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
//               //hint text style
//             ),
//
//           ),
//       ),
//
//       ),
//
//      // (onPressed: (){
//      //   _firestore.collection("messages").add({
//      //     "text":messagetext,
//      //     'sender':signedInUser.email,
//      //   });
//
//      //},
//     ],
//   ),
// )
//        )],
//     ),
//   ),
// ),
//  );
// }

