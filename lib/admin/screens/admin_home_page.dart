import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/admin/screens/add_new_grievance_page.dart';
import 'package:lj_grievance/admin/screens/all_grievance_page.dart';
import 'package:lj_grievance/admin/screens/approved_and_unapproved_user_page.dart';
import 'package:lj_grievance/admin/screens/batch_page.dart';
import 'package:lj_grievance/admin/screens/courses_page.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget{
  const AdminHomePage({super.key});
  @override
  State<AdminHomePage> createState() => _AdminPage();
}
class _AdminPage extends State<AdminHomePage> with TickerProviderStateMixin{
  late TabController controller;

  //Menu class
  NavigateToPage navPage = NavigateToPage();
  AllGrievance allGrievance = AllGrievance();
  AddGrievancePage addGrievancePage = AddGrievancePage();
  AllCoursePage allCoursePage = AllCoursePage();
  AllBatchPage allBatchPage = AllBatchPage();
  UsersPage usersPage = UsersPage();

  String profileName = "Unknown";

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: const Color(0xFFFFFFFF),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(text: const TextSpan(text: "Admin",style: TextStyle(color: Colors.blueAccent,fontSize: 25),children: [
                      TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
                    ])),
                  ),
                  const Divider(),
                  const SizedBox(height: 20,),
                  CustomMenuItem().customMenuItem(icon: Icons.person_2_outlined,color:const Color(0xFFFFFFFF),text: profileName,onclick: (){
                    Navigator.pushNamed(context, 'admin_profile');
                  }),
                  const SizedBox(height: 20,),
                  const Divider(thickness: 2,),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.mark_email_unread_outlined,text: "All grievance",color: allGrievance.isSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),onclick: (){
                        falseAllMenuActive();
                        allGrievance.isSelected = true;
                        value.context = context;
                        value.navigateTo(context: context,currWidget: allGrievance.allGrievance(context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.plus_one,color: addGrievancePage.isSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),text: "Add new grievance type",onclick: (){
                        falseAllMenuActive();
                        addGrievancePage.isSelected = true;
                        value.navigateTo(context: context,currWidget: addGrievancePage.addGrievancePage(context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.published_with_changes,color: usersPage.approvedSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),text: "Approved users",onclick: (){
                        falseAllMenuActive();
                        usersPage.approvedSelected = true;
                        value.navigateTo(context: context,currWidget: usersPage.usersPage(approvedSelect: true,context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.unpublished_outlined,color: usersPage.unapprovedSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),text: "Unapproved users",onclick: (){
                        falseAllMenuActive();
                        usersPage.unapprovedSelected = true;
                        value.navigateTo(context: context,currWidget: usersPage.usersPage(context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.library_books_outlined,color: allCoursePage.isSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),text: "Courses",onclick: (){
                        falseAllMenuActive();
                        allCoursePage.isSelected = true;
                        value.navigateTo(context: context,currWidget: allCoursePage.allCoursePage(context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.batch_prediction_outlined,color: allBatchPage.isSelected==true?const Color(0xFF000044):const Color(0xFFEBF2F9),text: "Batch",onclick: (){
                        falseAllMenuActive();
                        allBatchPage.isSelected = true;
                        value.navigateTo(context: context,currWidget: allBatchPage.allBatchPage(context: value.context));
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const Text("\t\tpogpks.pvt.ltd",style: TextStyle(fontSize: 10)),
                  const SizedBox(height:10),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: RichText(text: const TextSpan(text: "Admin",children: [
            TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
          ])),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                child: IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'admin_profile');
                }, icon: const Icon(Icons.person_2_outlined,color: Colors.white,)),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Consumer<NavigateToPage>(builder: (context, value, child) {
            value.context = context;
            return value.getNavigatePage();
          },),
        ),
      ),
    );
  }

  void falseAllMenuActive(){
    allBatchPage.isSelected = false;
    allCoursePage.isSelected = false;
    allGrievance.isSelected = false;
    usersPage.approvedSelected = false;
    usersPage.unapprovedSelected = false;
    addGrievancePage.isSelected = false;
  }

  void closeDrawer() async{
    Future.delayed(const Duration(microseconds: 1024),() {
      _scaffoldKey.currentState!.openEndDrawer();
    },);
  }

  void getUserInfo(){
    FirebaseFirestore.instance.collection("users").doc(Session().userId).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        var data = snapshot.data() as Map;
        profileName = data['name'];
      }
    });
  }
}