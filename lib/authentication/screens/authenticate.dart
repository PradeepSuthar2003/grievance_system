import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/authentication/screens/session.dart';

class Authenticate extends StatelessWidget{
  FirebaseAuth auth = FirebaseAuth.instance;
  Authenticate({super.key});
  @override
  Widget build(BuildContext context) {
    checkLogin(context: context);
    return const Scaffold(
      body: Center(child: Text("Splash")),
    );
  }

  void checkLogin({required BuildContext context}) async{
    await Future.delayed(const Duration(seconds: 2),() {
      if(auth.currentUser!=null){
        Session().userId = auth.currentUser!.uid;
        Navigator.pop(context);
        Navigator.pushNamed(context, 'user_home_page');
      }else{
        Navigator.pop(context);
        Navigator.pushNamed(context, 'signup_page');
      }
    },);
  }
}