import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/vaildation/validation.dart';

class AdminProfilePage extends StatelessWidget{
  AdminProfilePage({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  final users = FirebaseFirestore.instance.collection("users");

  final _formKey = GlobalKey<FormState>();
  final _changePasswordKey = GlobalKey<FormState>();

  TextEditingController name =  TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController conNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context){
    getUserInfo();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedButton().roundedButton(icon: Icons.arrow_back,radius: 20,onClick: (){
                        Navigator.pop(context);
                      }),
                      const Text("pogpks"),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 50,),
                  const Text("Profile",style: TextStyle(fontSize: 25),),
                  const SizedBox(height: 40,),
                  CustomInputField().customInputField(icon: Icons.abc_outlined, text: "", controller: name,validate: (value){
                    if(!value!.isValidName){
                      return "Enter valid name";
                    }
                    return null;
                  }),
                  const SizedBox(height: 30,),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      users.doc(Session().userId).update(
                        {
                          "name":name.text.toString(),
                        }
                      ).then((value){
                        ErrorMessage().errorMessage(context: context, errorMessage: "Updated");
                      });
                    }
                  },style: ButtonStyle(elevation: MaterialStateProperty.all(0)), child: const Text("Change Profile")),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 20,),
                  CustomMenuItem().customMenuItem(icon:Icons.exit_to_app,text: "SignOut", onclick: () {
                    auth.signOut();
                    Session().userId = "";
                    Session().role = "";
                    Session().email = "";
                    Navigator.pushNamedAndRemoveUntil(context, 'login_page', (route) => false);
                  }, color: Colors.white),
                  const SizedBox(height: 10,),
                  CustomMenuItem().customMenuItem(icon:Icons.change_circle_outlined,text: "Change Password", onclick: (){
                    auth.sendPasswordResetEmail(email: Session().email.toString()).then((value){
                      ErrorMessage().errorMessage(context: context, errorMessage: "Password reset email was send on register email");
                    }).onError((error, stackTrace){
                      ErrorMessage().errorMessage(context: context, errorMessage: error.toString().substring(30),ifError: true);
                    });
                  }, color: const Color(0xFFFFFFFF)),
                  const SizedBox(height: 20,),
                ]
          ),
            ),
          ),
        )
      ),
    );
  }

  void getUserInfo(){
    users.doc(Session().userId).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
          var data = snapshot.data() as Map;
          name.text = data['name'];
      }
    });
  }
}