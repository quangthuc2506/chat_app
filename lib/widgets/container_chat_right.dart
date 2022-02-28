import 'package:flutter/material.dart';

class ContainerChatRight extends StatelessWidget {
  String? text;
 ContainerChatRight({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 10),

        decoration:  BoxDecoration(
          borderRadius:const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.orange[600],
        ),
        width: 186,
        padding:const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: Text(text!),
      ),
    );
  }
}
