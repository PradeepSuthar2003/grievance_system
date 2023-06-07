import 'package:cloud_firestore/cloud_firestore.dart';
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

  String id="";

  final users = FirebaseFirestore.instance.collection("users");

  Widget adUpGrievanceForm({BuildContext? context,int index = 0}){
    fetchUserInfo(index);
    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: SingleChildScrollView(
        child: AlertDialog(title: SizedBox(
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
                CustomInputField().customInputField(controller: designation,icon: Icons.description_outlined,text: "Designation",validate: (value){
                  if(value.toString().trim() == ""){
                    return "Enter designation";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(readOnly: true,controller: email,icon: Icons.email_outlined,text: "Email",inputType: TextInputType.emailAddress,validate: (value){
                  if(!value!.isValidEmail){
                    return "Enter valid email";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: contact,icon: Icons.contact_page_outlined,text: "Contact no",inputType: TextInputType.number,validate: (value){
                  if(value.toString().trim()==""){
                    return "Enter contact";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(readOnly: true,controller: password,icon: Icons.lock_outline,text: "Password",obscureText: true,validate: (value){
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
                updateUserInfo();
                Navigator.pop(context!);
              }
            }, child: const Text("Update"))
          ],
        ),
      ),
    );
  }

  void fetchUserInfo(int index){
    users.where("").get().then((QuerySnapshot snapshot){
      var data = snapshot.docs[index].data() as Map;
      id = data['id'].toString();
      name.text = data['name'].toString();
      designation.text = data['designation'].toString();
      email.text = data['email'].toString();
      contact.text = data['contact'].toString();
      password.text = data['password'].toString();
    });
  }

  void updateUserInfo(){
    users.doc(id).update({
      "name":name.text.toString(),
      "designation":designation.text.toString(),
      "email":email.text.toString(),
      "contact":contact.text.toString(),
      "password":password.text.toString()
    });
  }
}