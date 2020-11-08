import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury2020/models/application.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';

class MyChatPage extends StatefulWidget {
  final JobApplication jobApplication;
  MyChatPage({this.jobApplication});

  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  int _counter = 0;
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color dynamiciconcolor = Colors.black54;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                        "https://avatars3.githubusercontent.com/u/37346450?s=460&v=4")),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.jobApplication.employerName ?? "Suraj Kumar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc('+917348991609')
              .collection('applications')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /*  print(snapshot.data);
              var data = json.decode(snapshot.data.docs);

              if ((data['type'] == "message" && data['in_uid'] == widget.jobApplication.uid) ||
                  (data['type'] == "offline" &&
                      data['dest_uid'] == widget.jobApplication.uid)) {
                print(snapshot.data);
                var message = data["message"];
                this.messages.add(ChatMessage(
                      text: message,
                      user: ChatUser(
                        name: widget.jobApplication.applicantName,
                        uid: widget.jobApplication.uid,
                        avatar: "https://avatars3.githubusercontent.com/u/37346450?s=460&v=4",
                      ),
                    ));
              } */
            }
            return DashChat(
                //showUserAvatar: true,

                messages: this.messages,
                inputMaxLines: 5,
                showAvatarForEveryMessage: false,
                onSend: (chatMessage) {
                  /*  this.channel.sink.add(
                      '{"type":"message","in_uid":"${widget.user.uid}","dest_uid":"${widget.uid}","message":"${ChatMessage.text}"}'); */

                  this.messages.add(chatMessage);
                  Timer(const Duration(seconds: 2), () {
                    this.messages.add(ChatMessage(
                          text:
                              "Hello ${widget.jobApplication.applicantName} !!\nThanks for applying at ${widget.jobApplication.companyName} seeking the post of a ${widget.jobApplication.title}.\n\nI am ${widget.jobApplication.employerName} and I will be guiding you throught the recruitment process.",
                          user: ChatUser(
                            name: widget.jobApplication.applicantName,
                            uid: widget.jobApplication.uid,
                            avatar:
                                "https://avatars3.githubusercontent.com/u/37346450?s=460&v=4",
                          ),
                        ));
                    setState(() {});
                  });
                },
                messageContainerDecoration: BoxDecoration(
                    color: Color(0xffffc45b),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0),
                      bottomLeft: const Radius.circular(15.0),
                      bottomRight: const Radius.circular(15.0),
                    )),
                timeFormat: DateFormat.Hm(),
                //leading: <Widget>[Container(width: 20,)],
                inputToolbarMargin:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15),
                user: ChatUser(
                    name: widget.jobApplication.employerName,
                    uid: widget.jobApplication.uid + "x",
                    avatar:
                        "https://avatars3.githubusercontent.com/u/37346450?s=460&v=4"),
                inputToolbarPadding: EdgeInsets.only(left: 12),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(color: Colors.grey),

                  //color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                inputDecoration:
                    InputDecoration(hintText: "Enter your message here"),
                //chatFooterBuilder: , //for the 'typing' message
                inputTextStyle:
                    TextStyle(fontSize: 15, color: Colors.grey[700]));
          },
        ));
  }
}
