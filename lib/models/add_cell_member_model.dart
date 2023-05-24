import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';

class AddCellMemberModel with ChangeNotifier{

  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  final addGrievanceUser = FirebaseFirestore.instance.collection("users");

  void createGrievanceCellMember({
    required BuildContext context,
    required BuildContext alertContext,
    required String email,
    required String password,
    required String gender,
    required String contact,
    required String designation,
    required String name
    }){
    isLoading = true;
    notifyListeners();
    auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      addGrievanceUser.doc(auth.currentUser!.uid).set({
        "approved_status":"2",
        "contact":contact,
        "designation":designation,
        "email":email,
        "password":password,
        "gender":gender,
        "name":name,
        "id":auth.currentUser!.uid,
        "role":"member"
      });
    }).then((value){
      isLoading = false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "New member added");
    }).onError((error, stackTrace){
      isLoading = false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "$error".substring(30),ifError: true);
    });
  }
}