import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:lj_grievance/user/screens/my_grievances.dart';
import 'package:lj_grievance/user/screens/post_new_grievance.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget{
  const UserHomePage({super.key});
  @override
  State<UserHomePage> createState() => _UserPage();
}
class _UserPage extends State<UserHomePage> with TickerProviderStateMixin{
  //Menu class
  NavigateToPage navPage = NavigateToPage();
  MyGrievance myGrievance = MyGrievance();
  PostNewGrievance postNewGrievance = PostNewGrievance();

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
                    child: RichText(text: const TextSpan(text: "Welcome to",style: TextStyle(color: Color(0xFF033500),fontSize: 17),children: [
                      TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 8))
                    ])),
                  ),
                  const Divider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomInputField().customInputField(themeColor: const Color(0xFF033500),readOnly: true,icon: Icons.person, text: "", controller: profileName),
                  ),
                  const SizedBox(height: 20,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.mark_email_unread_outlined,text: "My grievance report",color: myGrievance.isSelected?const Color(0xFF033500):const Color(0xFFE0F2F1),textColor: myGrievance.isSelected?Colors.white:Colors.black,onclick: (){
                        falseAllMenuActive();
                        myGrievance.isSelected = true;
                        value.navigateTo(currWidget: myGrievance.myGrievance(context: value.context), context: context);
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  Consumer<NavigateToPage>(
                    builder: (context, value, child) {
                      return CustomMenuItem().customMenuItem(icon: Icons.plus_one,text: "Post new grievance",color: postNewGrievance.isSelected?const Color(0xFF033500):const Color(0xFFE0F2F1),textColor: postNewGrievance.isSelected?Colors.white:Colors.black,onclick: (){
                        falseAllMenuActive();
                        postNewGrievance.isSelected = true;
                        value.navigateTo(currWidget: postNewGrievance.postNewGrievance(context: value.context), context: context);
                        closeDrawer();
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const Text("\t\tpogpks.pvt.ltd",style: TextStyle(fontSize: 10,color: Color(0xFF033500))),
                  const SizedBox(height:10),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: RichText(text: const TextSpan(text: "Welcome to",children: [
            TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
          ])),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                child: IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'user_profile_page');
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
    myGrievance.isSelected = false;
    postNewGrievance.isSelected = false;
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