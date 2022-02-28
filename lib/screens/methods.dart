import 'package:chat_app_basic/screens/chat_screen.dart';
import 'package:chat_app_basic/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
FirebaseFirestore _fireStore = FirebaseFirestore.instance;
void signOut() {
    LoginScreen.signOut();
  }
Future<void> signIn(GoogleSignIn googleSignIn) async {
  try {
    await googleSignIn.signIn();
    var user = googleSignIn.currentUser!;
    await _fireStore.collection('users').doc(user.id).set({
      "name": user.displayName,
      "email": user.email,
      "status" : "Unavailible"
    });
     
  } catch (e) {
    print("Error signing in $e");
  }
}
Map<String, dynamic>? userMap;

Future<void> searchUser() async {
  await _fireStore.collection('users').where("email",isEqualTo: ChatScreen.searchController.text)
  .get().then((value) => userMap = value.docs[0].data());
  print(userMap);
}

class FormatTime{
  String? time;
  String? format(DateTime? time){
  DateFormat formatter = DateFormat('HH:mm');
  final String date = formatter.format(time!);
  return date;
  }
  
}