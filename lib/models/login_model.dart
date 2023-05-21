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
      Session().userId = value.user!.uid;
      isLoading=false;
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(context, 'user_home_page', (route) => false);
      ErrorMessage().errorMessage(context: context, errorMessage: "Login successfully");
    }).onError((error, stackTrace) {
      isLoading=false;
      notifyListeners();
      ErrorMessage().errorMessage(context: context, errorMessage: "Something want wrong",ifError: true);
    });
  }
}