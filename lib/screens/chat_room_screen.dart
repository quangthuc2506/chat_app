import 'dart:io';

import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:chat_app_basic/screens/methods.dart';
import 'package:chat_app_basic/values/app_assets.dart';
import 'package:chat_app_basic/widgets/container_chat_left.dart';
import 'package:chat_app_basic/widgets/container_chat_right.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends StatefulWidget {
  GoogleSignInAccount? currentuser = googleSignIn.currentUser;
  GoogleSignInAccount? user;
  Map<String, dynamic>? userMap;
  String? chatRoomId;

  ChatRoomScreen({Key? key, this.chatRoomId, this.userMap, this.user})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    Firebase.initializeApp();
    
    super.initState();
  }

  var sendController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              splashRadius: Material.defaultSplashRadius * 0.7,
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 38,
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[100]),
                  child: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.grey,
                  )),
            ),
            title: Row(
              children: [
                IconButton(
                    splashRadius: Material.defaultSplashRadius * 0.7,
                    onPressed: () {},
                    icon: Stack(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                          backgroundColor: Colors.transparent,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 125,
                        child: Text(
                          widget.userMap!['name'],
                          overflow: TextOverflow.clip,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "Online now",
                          style: TextStyle(color: Colors.orange, fontSize: 10),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            actions: [
              Container(
                  width: 38,
                  height: 38,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[100]),
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: Material.defaultSplashRadius * 0.7,
                    icon: const Icon(
                      Icons.videocam_rounded,
                    ),
                    color: Colors.grey,
                    iconSize: 20,
                  )),
              Container(
                  width: 38,
                  height: 38,
                  margin: const EdgeInsets.only(top: 10, bottom: 10, right: 13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[100]),
                  child: IconButton(
                    splashRadius: Material.defaultSplashRadius * 0.7,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                    ),
                    color: Colors.grey,
                    iconSize: 20,
                  )),
            ]),
      ),
      bottomSheet: Container(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              margin: EdgeInsets.only(left: 15, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[100]),
              child: IconButton(
                  splashRadius: Material.defaultSplashRadius * 0.7,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[100]),
                    child: IconButton(
                      splashRadius: Material.defaultSplashRadius * 0.7,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        getImage();
                      },
                      icon: Icon(
                        Icons.add,
                        size: 38,
                      ),
                      color: Colors.orange,
                    ),
                  )),
            ),
            const VerticalDivider(
              indent: 21,
              endIndent: 21,
              color: Colors.grey,
              thickness: 2,
            ),
            Expanded(
              child: TextFormField(
                controller: sendController,
                decoration: InputDecoration(
                  hintText: "Type something",
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: Container(
                    width: 38,
                    margin: EdgeInsets.only(right: 15, top: 21, bottom: 21),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey[100]),
                    child: IconButton(
                      splashRadius: Material.defaultSplashRadius * 0.7,
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 13),
                      onPressed: () {
                        onSendMessage();
                      },
                      icon: Image.asset(AppAssets.arrowUp),
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            80 -
            AppBar().preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
                      controller: _scrollCtrl,

          physics: ScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
SchedulerBinding.instance!.addPostFrameCallback((_) {
      _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
    });
                        if (snapshot.data!.docs[index]['sendby'] ==
                            widget.currentuser!.displayName) {
                          if (map['type'] == 'text') {
                            return ContainerChatRight(
                                text: snapshot.data!.docs[index]['message']);
                          } else {
                            return map['message'].toString().isNotEmpty
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      width: 186,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 12),
                                      child: Image.network(map['message']),
                                    ),
                                  )
                                : const CircularProgressIndicator();
                          }

                          // Text(snapshot.data!.docs[index]['message'],style: TextStyle(color: Colors.black),);

                        } else {
                          if (map['type'] == 'text') {
                            return ContainerChatLeft(
                                text: snapshot.data!.docs[index]['message']);
                          } else {
                            return map['message'].toString().isNotEmpty
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      width: 186,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 12),
                                      child: Image.network(map['message']),
                                    ),
                                  )
                                : const CircularProgressIndicator();
                          }
                        }
                      },
                    );
                  } else {
                    print("Loi");
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSendMessage() async {
    if (sendController.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": widget.currentuser!.displayName,
        "message": sendController.text,
        "type": "text",
        "time": FieldValue.serverTimestamp()
      };
      sendController.clear();
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("enter some text");
    }
  }

  File? imageFile;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": widget.currentuser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp()
    });
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((onError) async {
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();
      status = 0;
    });
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
    }
  }
}
