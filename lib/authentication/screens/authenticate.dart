import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Center(child: CircleAvatar(backgroundImage: AssetImage("assets/images/splash_logo.jpg"),radius: 50,)),
    );
  }

  void checkLogin({required BuildContext context}) async{
    if(auth.currentUser!=null){
      getRole(auth.currentUser!.uid.toString());
    }
    await Future.delayed(const Duration(seconds: 3),() {
      if(auth.currentUser!=null){
        Session().userId = auth.currentUser!.uid;
        if(Session().role == "admin"){
          Navigator.pushNamedAndRemoveUntil(context, 'admin_home_page',(route) => false,);
        }else if(Session().role == "member"){
          Navigator.pushNamedAndRemoveUntil(context, 'cell_member_home_page',(route) => false,);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, 'user_home_page',(route) => false,);
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(context, 'login_page',(route) => false,);
      }
    },);
  }

  void getRole(String id){
    FirebaseFirestore.instance.collection("users").doc(id).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        var data = snapshot.data() as Map;
        Session().role = data['role'];
        Session().email = data['email'];
      }
    });
  }
}


