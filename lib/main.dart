import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/screens/admin_profile_page.dart';
import 'package:lj_grievance/authentication/screens/login_page.dart';
import 'package:lj_grievance/authentication/screens/signup_page.dart';
import 'package:lj_grievance/cell_members/screens/cell_member_home_page.dart';
import 'package:lj_grievance/cell_members/screens/cell_member_profile_page.dart';
import 'package:lj_grievance/cell_members/screens/update_user_grievance_page.dart';
import 'package:lj_grievance/user/screens/user_home_page.dart';
import 'package:lj_grievance/user/screens/user_profile_page.dart';
import 'admin/screens/admin_home_page.dart';
import 'authentication/screens/authenticate.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GrievanceApp());
}

class GrievanceApp extends StatelessWidget{
  const GrievanceApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'authenticate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'admin_home_page':(context) => const AdminHomePage(),
        'admin_profile':(context) => AdminProfilePage(),
        'cell_member_home_page':(context) => const MemberHomePage(),
        'update_user_grievance_page':(context) => const UpdateUserGrievancePage(),
        'cell_member_profile_page':(context) => CellMemberProfilePage(),
        'user_home_page':(context) => const UserHomePage(),
        'user_profile_page':(context) => UserProfilePage(),
        'authenticate':(context) => Authenticate(),
        'login_page':(context) => const LoginPage(),
        'signup_page':(context) => const SignUpPage(),
      },
    );
  }
}

