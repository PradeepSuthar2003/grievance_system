import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lj_grievance/Utils/error_message.dart';

class ApprovedUserModel with ChangeNotifier{

  bool isLoading = false;

  final users = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;

  void updateUser({
    required String oldId,
    bool approved=false,
    required String newId,
    required BuildContext context,
    required BuildContext alertContext,
    required String name,
    required String gender,
    required String selectedCourse,
    required String selectedBatch,
    required String enroll,
    required String email,
    required String contact,
    required String password,
    required String selectedApproval
  }){
    if(approved){
      isLoading = true;
      notifyListeners();
      auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        users.doc(oldId).delete().then((value){
          users.doc(newId).set(
              {
                'id':newId,
                'name':name,
                'gender':gender,
                'course':selectedCourse,
                'batch':selectedBatch,
                'enrollment':enroll,
                'email':email,
                'contact':contact,
                'password':password,
                'approved_status':approved?"1":"0",
                'role':'user',
              }
          ).then((value){
          }).onError((error, stackTrace){
          });
        });
      }).then((value){
        isLoading = false;
        notifyListeners();
        Navigator.pop(alertContext);
        ErrorMessage().errorMessage(context: context, errorMessage: "Approved successfully");
      }).onError((error, stackTrace){
        isLoading = false;
        notifyListeners();
        Navigator.pop(alertContext);
        ErrorMessage().errorMessage(context: context, errorMessage:"$error".substring(30),ifError: true);
      });
    }else{
      isLoading = true;
      notifyListeners();
      users.doc(oldId).update({
        "approved_status":selectedApproval == "Approved" && !approved?"1":"0",
        "batch":selectedBatch,
        "contact":contact,
        "course":selectedCourse,
        "email":email,
        "enrollment":enroll,
        "name":name,
        "password":password,
      }).then((value){
        isLoading = false;
        notifyListeners();
        Navigator.pop(alertContext);
        ErrorMessage().errorMessage(context: context, errorMessage: "Updated");
      }).onError((error, stackTrace){
        isLoading = false;
        notifyListeners();
        Navigator.pop(alertContext);
        ErrorMessage().errorMessage(context: context, errorMessage: "$error".substring(30),ifError: true);
      });
    }
  }
}