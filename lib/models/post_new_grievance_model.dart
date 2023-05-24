import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/authentication/screens/session.dart';

class PostNewGrievanceModel with ChangeNotifier{
  bool isLoading = false;

  final postGrievance = FirebaseFirestore.instance.collection("grievances");

  void postGrievanceMessage({required BuildContext context,String? selectedGrievanceType,required String subject,required String details}){
    isLoading = true;
    notifyListeners();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    postGrievance.doc(id).set({
      "id":id,
      "user_id":Session().userId.toString(),
      "grievance_type":selectedGrievanceType,
      "subject":subject,
      "details":details,
      "reply":"0",
      "status":"0",
      "date":DateTime.now().toString()
    }).then((value){
      isLoading = false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "Submit successfully");
    }).onError((error, stackTrace){
      isLoading = false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "$error".substring(30),ifError: true);
    });
  }
}