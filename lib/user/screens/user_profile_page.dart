import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class UserProfilePage extends StatelessWidget{
  UserProfilePage({super.key});

  TextEditingController name =  TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RoundedButton().roundedButton(icon: Icons.arrow_back,radius: 20,onClick: (){
                            Navigator.pop(context);
                          }),
                        ],
                      ),
                      const SizedBox(height: 50,),
                      RichText(text: const TextSpan(text: "Your",style: TextStyle(color: Colors.blueAccent,fontSize: 20),children: [
                        TextSpan(text: "\tProfile",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
                      ])),
                      const SizedBox(height: 30,),
                      CustomInputField().customInputField(icon: Icons.abc_outlined, text: "", controller: name),
                      const SizedBox(height: 10,),
                      CustomInputField().customInputField(icon: Icons.email_outlined, text: "", controller: email),
                      const SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){},style: ButtonStyle(elevation: MaterialStateProperty.all(0)), child: const Text("Change Profile"),),
                      const Divider(),
                      const SizedBox(height: 20,),
                      CustomMenuItem().customMenuItem(icon:Icons.change_circle_outlined,text: "Change Password", onclick: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(

                            title: Form(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                                child: Column(
                                  children:[
                                    const Text("Change Password"),
                                    const SizedBox(height: 20,),
                                    CustomInputField().customInputField(icon: Icons.change_circle_outlined, text: "New password", controller: newPassword),
                                    const SizedBox(height: 20,),
                                    CustomInputField().customInputField(icon: Icons.change_circle_outlined, text: "Confirm new password", controller: newPassword),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("Cancel")),
                              TextButton(onPressed: (){}, child: const Text("Update")),
                            ],
                          );
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
}