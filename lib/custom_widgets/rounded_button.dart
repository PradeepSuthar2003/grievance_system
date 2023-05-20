import 'package:flutter/material.dart';

class RoundedButton{
  Widget roundedButton({required IconData icon,double radius = 25.0,VoidCallback? onClick,MaterialColor color = Colors.blue}){
    return CircleAvatar(backgroundColor: color,radius: radius,child: IconButton(icon: Icon(icon,color: Colors.white,),onPressed: onClick,),);
  }
}