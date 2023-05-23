import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/vaildation/validation.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_input_field.dart';

class AddGrievancePage with ChangeNotifier{
  bool isSelected = false;

  Gender? gender = Gender.Male;

  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final addGrievanceUser = FirebaseFirestore.instance.collection("users");

  late BuildContext thisPageContext;

  Widget addGrievancePage({BuildContext? context}){
    thisPageContext = context!;
    return SingleChildScrollView(
      child: ChangeNotifierProvider<NavigateToPage>(
        create: (context) => NavigateToPage(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                const Text("Add new grievance cell member",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
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
                        const Text("Gender",style: TextStyle(fontWeight: FontWeight.w700),),
                        RadioMenuButton(value: Gender.Male, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Male")),
                        RadioMenuButton(value: Gender.Female, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Female")),
                        RadioMenuButton(value:Gender.Other, groupValue: gender, onChanged:(val) {
                          gender = val;
                          value.notifyListeners();
                        }, child: const Text("Other")),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: designation,icon: Icons.description_outlined,text: "Designation",validate: (value){
                  if(value.toString().trim() == ""){
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
                  if(value.toString().trim()==""){
                    return "Enter contact no";
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
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add member"),
                    RoundedButton().roundedButton(icon: Icons.add,onClick: (){
                      if(_formKey.currentState!.validate()){
                        createGrievanceCellMember();
                      }
                    }),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void emptyForm(){
    name.text = "";
    email.text = "";
    designation.text = "";
    password.text = "";
    contact.text = "";
  }

  void createGrievanceCellMember(){
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    addGrievanceUser.doc(id).set({
      "approved_status":"2",
      "contact":contact.text.toString(),
      "designation":designation.text.toString(),
      "email":email.text.toString(),
      "password":password.text.toString(),
      "gender":gender.toString().substring(7),
      "name":name.text.toString(),
      "id":id,
      "role":"member"
    }).then((value){
      emptyForm();
      ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "New member added");
    });
  }
}