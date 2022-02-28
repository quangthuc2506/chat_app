import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  IconData? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  bool obscureText;
  MyTextFormField(
      {Key? key, this.prefixIcon, this.suffixIcon, this.hintText,this.obscureText = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon,color: Colors.grey,),
            suffixIcon: suffixIcon,
            fillColor: Colors.grey[200],
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.orange,width: 2),
                borderRadius: BorderRadius.circular(10),
                
                ),

            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
