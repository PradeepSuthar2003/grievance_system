import 'package:flutter/material.dart';

class ErrorMessage{
  void errorMessage({required BuildContext context,required String errorMessage,bool ifError = false}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: ifError?Colors.red:Colors.teal,));
  }
}