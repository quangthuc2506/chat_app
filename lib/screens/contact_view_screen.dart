import 'package:chat_app_basic/screens/chat_screen.dart';
import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:chat_app_basic/widgets/dialog_sign_out.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ContactViewScreen extends StatefulWidget {
  GoogleSignInAccount? user;
  ContactViewScreen({Key? key, this.user}) : super(key: key);

  @override
  _ContactViewScreenState createState() => _ContactViewScreenState();
}

class _ContactViewScreenState extends State<ContactViewScreen> {

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialogSignOut(context,widget.user!);
                
              },
              icon: Stack(children: [
                SizedBox(
                    width: 28,
                    height: 28,
                    child: GoogleUserCircleAvatar(identity: widget.user!)),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                  ),
                )
              ]))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 153,
                margin: const EdgeInsets.only(top: 30, bottom: 24),
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 24),
                        width: 115,
                        height: 153,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                width: double.infinity,
                height: 171,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 103,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 13),
                      height: 125,
                      width: MediaQuery.of(context).size.width - 103 - 14 - 27,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 15),
                              width:
                                  MediaQuery.of(context).size.width - 103 - 14,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey,
                              ),
                            );
                          }))
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 78, right: 27),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen(user: widget.user,)));
          },
          child: const Icon(Icons.chat_bubble),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}
