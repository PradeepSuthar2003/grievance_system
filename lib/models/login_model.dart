import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/authentication/screens/session.dart';

class LoginModel with ChangeNotifier{
  

  
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isPasswordNotVisible=true;

  void login({required String email,required String password,required BuildContext context}) async{
    isLoading=true;
    notifyListeners();
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          var data = snapshot.data() as Map;
          if (data['role'] == "user") {
            setLoginDetails(context);
            Navigator.pushNamedAndRemoveUntil(
                context, 'user_home_page', (route) => false);
          } else if (data['role'] == "member") {
            setLoginDetails(context);
            Navigator.pushNamedAndRemoveUntil(
                context, 'cell_member_home_page', (route) => false);
          }
        }
      }).onError((error, stackTrace) {});
      setLoginDetails(context);
      Navigator.pushNamedAndRemoveUntil(
          context, 'admin_home_page', (route) => false);
    }).onError((error, stackTrace) {
      isLoading=false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "Something want wrong",ifError: true);
    });
  }

void setLoginDetails(BuildContext context){
  isLoading=false;
  notifyListeners();
  ErrorMessage().errorMessage(context: context, errorMessage: "Login successfully");
}
}