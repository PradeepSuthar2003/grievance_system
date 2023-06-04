import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/cell_members/screens/all_user_grievance.dart';
import 'package:lj_grievance/cell_members/screens/post_grievance_type_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:provider/provider.dart';

class MemberHomePage extends StatefulWidget{
  const MemberHomePage({super.key});
  @override
  State<MemberHomePage> createState() => _MemberHomePage();
}
class _MemberHomePage extends State<MemberHomePage> with TickerProviderStateMixin{
  //Menu class
  NavigateToPage navPage = NavigateToPage();
  PostGrievanceType postGrievanceType = PostGrievanceType();
  AllUserGrievance allUserGrievance = AllUserGrievance();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController profileName = TextEditingController();

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
                    child: RichText(text: const TextSpan(text: "Cell Member",style: TextStyle(color: Colors.blueAccent,fontSize: 20),children: [
                      TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
                    ])),
                  ),
                  const Divider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomInputField().customInputField(readOnly: true,icon: Icons.person, text: "", controller: profileName),
                  ),
                  const SizedBox(height: 20,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.mark_email_unread_outlined,text: "All grievance message",color:allUserGrievance.isSelected?const Color(0xFF000044):const Color(0xFFEBF2F9),onclick: (){
                        falseAllActiveMenuItem();
                        allUserGrievance.isSelected = true;
                        value.navigateTo(currWidget: AllUserGrievance().allUserGrievance(context: context), context: context);
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.type_specimen_outlined,text: "Post grievance type",color:postGrievanceType.isSelected?const Color(0xFF000044):const Color(0xFFEBF2F9),onclick: (){
                        falseAllActiveMenuItem();
                        postGrievanceType.isSelected = true;
                        value.navigateTo(currWidget: PostGrievanceType().postGrievanceType(context: context), context: context);
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
          title: RichText(text: const TextSpan(text: "Cell Member",children: [
            TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
          ])),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                child: IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'cell_member_profile_page');
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

  void falseAllActiveMenuItem(){
    postGrievanceType.isSelected = false;
    allUserGrievance.isSelected = false;
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
        profileName.text = data['name'];
      }
    });
  }

}