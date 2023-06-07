import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';

class UpdateGrievanceModel with ChangeNotifier{

  bool isLoading = false;

  final grievance = FirebaseFirestore.instance.collection("grievances");

  void giveReply(String id,BuildContext context,String reply,BuildContext updatePageContext){
    isLoading = true;
    notifyListeners();
    grievance.doc(id).update({
      "reply":reply,
      "status":"1",
    }).then((value) {
      isLoading = true;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "Reply successfully");
      Navigator.pop(context);
      Navigator.pop(updatePageContext);
    }).onError((error, stackTrace){
      isLoading = true;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "$error".substring(30),ifError: true);
    });
  }
}