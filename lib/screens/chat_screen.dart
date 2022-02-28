import 'package:chat_app_basic/screens/chat_room_screen.dart';
import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:chat_app_basic/screens/methods.dart';
import 'package:chat_app_basic/widgets/dialog_sign_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  GoogleSignInAccount? user = googleSignIn.currentUser;
  static TextEditingController searchController = TextEditingController();
  ChatScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSearching = false;
  Map<String, dynamic>? userMap;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  Future<void> searchUser() async {
    setState(() {
      isSearching = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: ChatScreen.searchController.text)
        .get()
        .then((value) {
          if(value.docs.isNotEmpty){
            setState(() {
        userMap = value.docs[0].data();
      });
          }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            splashRadius: Material.defaultSplashRadius * 0.7,
            onPressed: () {},
            icon: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    showDialogSignOut(context, widget.user!);
                  },
                  icon: CircleAvatar(
                    child: GoogleUserCircleAvatar(identity: widget.user!),
                  ),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: ChatScreen.searchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      
                      searchUser();
                    },
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              userMap == null
                  ? Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.data != null) {
                                
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  
                                  itemBuilder: (context, index) {
                                     print("user 1: ${widget.user!.displayName!}");
                      print("user 2: ${snapshot.data!.docs[index]['name']}");
                                    return Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            String roomId = chatRoomId(
                                                widget.user!.displayName!,
                                                snapshot.data!.docs[index]['name']);
                        
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatRoomScreen(
                                                          chatRoomId: roomId,
                                                          userMap: snapshot.data!.docs[0].data() as Map<String,dynamic>,
                                                          user: widget.user,
                                                        )));
                                          },
                                          splashColor: Colors.grey,
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: SizedBox(
                                                  width: 42,
                                                  height: 42,
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data!.docs[index]['name'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatroom')
                    .doc(chatRoomId(
                                                widget.user!.displayName!,
                                                snapshot.data!.docs[index]['name']))
                    .collection('chats')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                     
                  if (snapshot1.data != null && snapshot1.data!.docs.isNotEmpty){
                    print("da vao day: ${snapshot1.data!.docs.isEmpty}");
                    return Text(snapshot1.data!.docs[0]['message'],
                    overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange),);
                  } else {
                    return Text("");
                  }
                },
              ),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatroom')
                    .doc(chatRoomId(
                                                widget.user!.displayName!,
                                                snapshot.data!.docs[index]['name']))
                    .collection('chats')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot2.data != null && snapshot2.data!.docs.isNotEmpty) {
                    print('check snapshot 2: ${snapshot2.data!.docs.isNotEmpty}');
                    return Text(
                      
                      snapshot2.data!.docs[0]['time'] != null ?
                      FormatTime().format((snapshot2.data!.docs[0]['time'] as Timestamp).toDate())!
                      : ""
                      ,


                      
                    overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange),);
                  } else {
                    print('check snapshot 2 emty: ${snapshot2.data!.docs.isNotEmpty}');
                    return const Text("");
                  }
                },
              ),
                                                        Container(
                                                          width: 15,
                                                          height: 15,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            })
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            String roomId = chatRoomId(
                                widget.user!.displayName!, userMap!['name']);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoomScreen(
                                          chatRoomId: roomId,
                                          userMap: userMap,
                                          user: widget.user,
                                        )));
                          },
                          splashColor: Colors.grey,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userMap!['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          margin: EdgeInsets.only(top: 5),
                                          child: const Text(
                                            "you are so beautiful you are so beautiful you are so beautiful you are so beautiful you are so beautiful",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "2 min ago",
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                        Container(
                                          width: 15,
                                          height: 15,
                                          margin: EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.orange,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
