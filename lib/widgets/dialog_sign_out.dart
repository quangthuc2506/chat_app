import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:chat_app_basic/screens/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';

Future<void> showDialogSignOut(
    BuildContext context, GoogleSignInAccount user) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: GoogleUserCircleAvatar(identity: user)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.displayName!,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        signOut();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                      icon: Icon(Icons.logout),
                      label: Text("sign out"))
                ],
              ),
            ));
      });
}
