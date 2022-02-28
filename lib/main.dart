import 'package:chat_app_basic/screens/chat_room_screen.dart';
import 'package:chat_app_basic/screens/chat_screen.dart';
import 'package:chat_app_basic/screens/contact_view_screen.dart';
import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
