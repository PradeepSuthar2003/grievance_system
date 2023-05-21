import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';

class SignUpModel with ChangeNotifier {

  bool isLoading = false;
  bool isPasswordNotVisible = true;

  final ref = FirebaseFirestore.instance.collection("users");

  void signUp(
      {required String name,
      required String gender,
      required String course,
      required String batch,
      required String enroll,
      required String email,
      required String contact,
      required String password,
      required BuildContext context
      }) {
    isLoading = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    ref.doc(id).set(
      {
        'id':id,
        'name':name,
        'gender':gender,
        'course':course,
        'batch':batch,
        'enrollment':enroll,
        'email':email,
        'contact':contact,
        'password':password,
        'approved_status':'0'
      }
    ).then((value){
      isLoading=false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "Signup successfully");
      Navigator.pushNamedAndRemoveUntil(context, 'login_page', (route) => false);
    }).onError((error, stackTrace){
      isLoading=false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "some went wrong",ifError: true);
    });
  }
}
