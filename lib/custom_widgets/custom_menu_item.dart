import 'package:flutter/material.dart';

class CustomMenuItem {
  Widget customMenuItem({IconData? icon,required String text,required VoidCallback onclick,required Color color,Color textColor = Colors.black54}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Row(
      children: [
        Expanded(
            child: Container(
          height: 50,
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: onclick,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(child: Icon(icon),),
                  const SizedBox(width: 20,),
                  SizedBox(width: 150,child: Text(text,style: TextStyle(color: textColor),)),
                ],
              ),
            ),
          ),
        ))
      ],
    )
      ],
    );
  }
}
