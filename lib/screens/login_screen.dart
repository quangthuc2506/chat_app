import 'package:chat_app_basic/screens/chat_room_screen.dart';
import 'package:chat_app_basic/screens/contact_view_screen.dart';
import 'package:chat_app_basic/screens/methods.dart';
import 'package:chat_app_basic/utils/color_util.dart';
import 'package:chat_app_basic/values/app_assets.dart';
import 'package:chat_app_basic/widgets/my_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static void signOut() async {
    googleSignIn.disconnect();
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    Firebase.initializeApp();
    googleSignIn.onCurrentUserChanged.listen((account) {
      if (mounted == true) {
        setState(() {
          _currentUser = account;
          if (_currentUser != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactViewScreen(
                          user: _currentUser,
                        )),
                (route) => false);
          }
        });
      }
    });
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundLogin),
                alignment: Alignment.topCenter)),
        child: Container(
          width: double.infinity,
          height: 580,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(120)),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Padding(
                padding: EdgeInsets.only(top: 55, bottom: 55),
                child: Text(
                  "Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: ColorUtil.toColor("#FFA925")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: MyTextFormField(
                    hintText: "Enter your email", prefixIcon: Icons.email),
              ),
              MyTextFormField(
                obscureText: obscureText,
                hintText: "Enter your password",
                prefixIcon: Icons.lock,
                suffixIcon: GestureDetector(
                  child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey),
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6, bottom: 82),
                child: Text("Forgot Password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.orange)),
              ),
              Container(
                height: 58,
                margin: const EdgeInsets.only(bottom: 28),
                child: ElevatedButton.icon(
                    onPressed: () {
                      signIn(googleSignIn);
                    },
                    icon: Image.asset(
                      AppAssets.logoGoogle,
                      scale: 4,
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))
                        // primary: Color(0xFF982F)
                        ),
                    label: Text("Sign in with Google")),
              ),
              Container(
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Login",
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(13),
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> signIn() async {
//   try {
//     await _googleSignIn.signIn();
//   } catch (e) {
//     print("Error signing in $e");
//   }
// }
