import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/screens/all_grievance_page.dart';

class NavigateToPage with ChangeNotifier{
  late BuildContext context;
  Widget currWidget = const Center(child: Text("Hello"));
  Widget? navigateTo({required Widget currWidget,required BuildContext context}){
    this.context = context;
    this.currWidget = currWidget;
    notifyListeners();
    return null;
  }

  Widget getNavigatePage(){
    return currWidget;
  }
}