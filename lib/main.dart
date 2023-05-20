import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/screens/admin_profile_page.dart';
import 'package:lj_grievance/cell_members/screens/cell_member_home_page.dart';
import 'package:lj_grievance/cell_members/screens/update_user_grievance_page.dart';
import 'admin/screens/admin_home_page.dart';

void main(){
  runApp(const GrievanceApp());
}

class GrievanceApp extends StatelessWidget{
  const GrievanceApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'cell_member_home_page',
      routes: {
        'admin_home_page':(context) => const AdminHomePage(),
        'admin_profile':(context) => AdminProfilePage(),
        'cell_member_home_page':(context) => const MemberHomePage(),
        'update_user_grievance_page':(context) => const UpdateUserGrievancePage(),
      },
    );
  }
}

