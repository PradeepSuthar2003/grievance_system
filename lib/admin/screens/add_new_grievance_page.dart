import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/models/add_cell_member_model.dart';
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
  final auth = FirebaseAuth.instance;

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
                const Text("Add new grievance cell member",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Color(0xFF033500)),),
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
                ChangeNotifierProvider<AddCellMemberModel>(
                  create: (context) => AddCellMemberModel(),
                  child: Consumer<AddCellMemberModel>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Add member"),
                          RoundedButton().roundedButton(haveTwoChild: value.isLoading,child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),icon: Icons.add,onClick: (){
                            if(_formKey.currentState!.validate()){
                              value.createGrievanceCellMember(context: thisPageContext, alertContext: context, email: email.text.toString(), password: password.text.toString(), gender: gender.toString().substring(7), contact: contact.text.toString(), designation: designation.text.toString(), name: name.text.toString());
                              emptyForm();
                            }
                          }),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void emptyForm() async{
    await Future.delayed(const Duration(seconds: 1),(){
      name.text = "";
      email.text = "";
      designation.text = "";
      password.text = "";
      contact.text = "";
    });
  }
}