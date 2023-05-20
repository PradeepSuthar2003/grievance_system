import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/vaildation/validation.dart';
import 'package:provider/provider.dart';

class AdUpGrievanceForm{

  Gender? gender = Gender.Male;

  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget adUpGrievanceForm({BuildContext? context}){
    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: SingleChildScrollView(
        child: AlertDialog(title: Container(
          width: 450,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const Text("Update grievance cell member",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 30,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Enter name",validate: (value){
                  if(!value!.isValidName){
                    return "Enter valid name";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),

                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        const Text("Gender",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                        RadioMenuButton(value: Gender.Male, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Male",style: TextStyle(fontSize: 10),)),
                        RadioMenuButton(value: Gender.Female, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Female",style: TextStyle(fontSize: 10),)),
                        RadioMenuButton(value:Gender.Other, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Other",style: TextStyle(fontSize: 10),)),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: designation,icon: Icons.description_outlined,text: "Designation",validate: (value){
                  if(value!.isNotNull){
                    return "Enter designation";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: email,icon: Icons.email_outlined,text: "Email",inputType: TextInputType.emailAddress,validate: (value){
                  if(!value!.isValidEmail){
                    return "Enter valid email";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: contact,icon: Icons.contact_page_outlined,text: "Contact no",inputType: TextInputType.number,validate: (value){
                  if(value!.isNotNull){
                    return "Enter contact";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: password,icon: Icons.lock_outline,text: "Password",obscureText: true,validate: (value){
                  if(!value!.isValidPassword){
                    return "Enter valid password";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context!);
            }, child: const Text("Cancel")),
            TextButton(onPressed: (){
              if(_formKey.currentState!.validate()){

              }
            }, child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}