import 'package:flutter/material.dart';

class ContainerChatLeft extends StatelessWidget {
  String? text;
   ContainerChatLeft({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10),

        decoration: BoxDecoration(
          borderRadius:const BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.grey[200],
        ),
        width: 186,
        padding:const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: Text(text!),
      ),
    );
  }
}
