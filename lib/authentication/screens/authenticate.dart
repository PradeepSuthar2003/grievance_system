import 'package:flutter/cupertino.dart';
import 'package:lj_grievance/authentication/screens/session.dart';

class Authenticate{
  BuildContext context;
  Authenticate({required this. context});
  Widget checkLogin(){
    if(Session().userId!=null){
      Navigator.pushNamed(context, 'user_home_page');
    }else{
      Navigator.pushNamed(context, 'signup_page');
    }
    return Text("jjje");
  }
}