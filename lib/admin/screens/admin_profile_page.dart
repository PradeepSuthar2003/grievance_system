import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/custom_menu_item.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/vaildation/validation.dart';

class AdminProfilePage extends StatelessWidget{
  AdminProfilePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _changePasswordKey = GlobalKey<FormState>();

  TextEditingController name =  TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context){
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
                  }),
                  const SizedBox(height: 20,),
                  CustomInputField().customInputField(icon: Icons.email_outlined, text: "", controller: email,validate: (value){
                    if(!value!.isValidEmail){
                      return "Enter valid name";
                    }
                  }),
                  const SizedBox(height: 30,),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){

                    }
                  },style: ButtonStyle(elevation: MaterialStateProperty.all(0)), child: const Text("Change Profile"),),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 20,),
                  CustomMenuItem().customMenuItem(icon:Icons.change_circle_outlined,text: "Change Password", onclick: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(

                        title: Form(
                          key: _changePasswordKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                            child: Column(
                              children:[
                                const Text("Change Password"),
                                const SizedBox(height: 20,),
                                CustomInputField().customInputField(icon: Icons.change_circle_outlined, text: "New password", controller: newPassword,validate: (value){
                                  if(!value!.isValidPassword){
                                    return "Enter valid password";
                                  }
                                  return null;
                                }),
                                const SizedBox(height: 20,),
                                CustomInputField().customInputField(icon: Icons.change_circle_outlined, text: "Confirm new password", controller: newPassword,validate: (value){
                                  if(!value!.isValidPassword){
                                    return "Enter valid password";
                                  }
                                  return null;
                                }),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: const Text("Cancel")),
                          TextButton(onPressed: (){
                            if(_changePasswordKey.currentState!.validate()){}
                          }, child: const Text("Update")),
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