import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class UserForm{

  List<String> courseList = ['MCA','BCA'];
  String? selectedCourse;

  List<String> batchList = ['2018','2019'];
  String? selectedBatch;

  List<String> approvalList = ['Approved','Unapproved'];
  String? selectedApproval;

  TextEditingController enroll = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget userForm({BuildContext? context}){
    selectedCourse = courseList[0];
    selectedBatch = batchList[0];
    selectedApproval = approvalList[0];

    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: SingleChildScrollView(
        child: AlertDialog(title: Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const Text("Update user",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
              const SizedBox(height: 30,),
              CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Enter name"),
              const SizedBox(height: 15,),
              CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Enter enroll"),
              const SizedBox(height: 15,),
              Consumer<NavigateToPage>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Select course"),
                      DropdownButton(items: courseList.map((String item){
                        return DropdownMenuItem(value: item,child: Text(item),);
                      }).toList(), onChanged: (val){ selectedCourse = val; value.notifyListeners();},value: selectedCourse,),
                    ],
                  );
                },
              ),

              Consumer<NavigateToPage>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Select batch"),
                      DropdownButton(items: batchList.map((String item){
                        return DropdownMenuItem(value: item,child: Text(item),);
                      }).toList(), onChanged: (val){ selectedBatch = val; value.notifyListeners();},value: selectedBatch,),
                    ],
                  );
                },
              ),

              const SizedBox(height: 15,),
              CustomInputField().customInputField(controller: email,icon: Icons.email_outlined,text: "Email",inputType: TextInputType.emailAddress),
              const SizedBox(height: 15,),
              CustomInputField().customInputField(controller: contact,icon: Icons.contact_page_outlined,text: "Contact no",inputType: TextInputType.number),
              const SizedBox(height: 15,),
              CustomInputField().customInputField(controller: password,icon: Icons.lock_outline,text: "Password"),
              const SizedBox(height: 15,),
              Consumer<NavigateToPage>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Approve status"),
                      DropdownButton(items: approvalList.map((String item){
                        return DropdownMenuItem(value: item,child: Text(item),);
                      }).toList(), onChanged: (val){ selectedApproval = val; value.notifyListeners();},value: selectedApproval,),
                    ],
                  );
                },
              ),

            ],
          ),
        ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context!);
            }, child: const Text("Cancel")),
            TextButton(onPressed: (){}, child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}