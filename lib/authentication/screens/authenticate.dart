import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lj_grievance/authentication/screens/session.dart';

class Authenticate extends StatelessWidget{
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    checkLogin(context: context);
    return const Scaffold(
      body: Center(child: Text("Splash")),
    );
  }

  void checkLogin({required BuildContext context}) async{
    await Future.delayed(const Duration(seconds: 2),() {
      if(Session().userId!=null){
        Navigator.pushNamed(context, 'user_home_page');
      }else{
        Navigator.pushNamed(context, 'signup_page');
      }
    },);
  }
}