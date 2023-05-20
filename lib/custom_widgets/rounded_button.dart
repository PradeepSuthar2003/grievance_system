import 'package:flutter/material.dart';

class RoundedButton{
  Widget roundedButton({required IconData icon,double radius = 25.0,VoidCallback? onClick}){
    return CircleAvatar(radius: radius,child: IconButton(icon: Icon(icon,color: Colors.white,),onPressed: onClick,),);
  }
}