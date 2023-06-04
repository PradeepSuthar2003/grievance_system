import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/screens/all_grievance_page.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/cell_members/screens/all_user_grievance.dart';
import 'package:lj_grievance/user/screens/my_grievances.dart';

class NavigateToPage with ChangeNotifier{
  late BuildContext context;
  Widget currWidget = Session().role == "admin"?AllGrievance().allGrievance():Session().role == "member"?AllUserGrievance().allUserGrievance():MyGrievance().myGrievance();
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