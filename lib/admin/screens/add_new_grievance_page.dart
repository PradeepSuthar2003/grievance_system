import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
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

  final _addGrievanceController = GlobalKey<FormState>();
  Widget addGrievancePage(){
    return SingleChildScrollView(
      child: ChangeNotifierProvider<NavigateToPage>(
        create: (context) => NavigateToPage(),
        child: Form(
          key: _addGrievanceController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                const Text("Add new grievance cell member",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 30,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Enter name"),
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
                CustomInputField().customInputField(controller: designation,icon: Icons.description_outlined,text: "Designation"),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: email,icon: Icons.email_outlined,text: "Email",inputType: TextInputType.emailAddress),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: contact,icon: Icons.contact_page_outlined,text: "Contact no",inputType: TextInputType.number),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: password,icon: Icons.lock_outline,text: "Password"),
                const SizedBox(height: 15,),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add member"),
                    RoundedButton().roundedButton(icon: Icons.add),
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
}