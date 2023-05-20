import 'package:flutter/cupertino.dart';

class Authenticate{
  BuildContext context;
  Authenticate({required this. context});
  Widget checkLogin(){
    if(true){
      Navigator.pushNamed(context, 'user_home_page');
    }
    return Text("jjje");
  }
}