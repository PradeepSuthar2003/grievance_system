import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/models/approved_user_model.dart';
import 'package:lj_grievance/vaildation/validation.dart';
import 'package:provider/provider.dart';

class UserForm{

  final _formKey = GlobalKey<FormState>();

  List<String> courseList = [];
  String? selectedCourse;

  List<String> batchList = [];
  String? selectedBatch;

  List<String> approvalList = ['Approved','Unapproved'];
  String? selectedApproval;

  TextEditingController enroll = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  late int index;
  String id = "";
  String? gender;

  final users = FirebaseFirestore.instance.collection("users");
  final courses = FirebaseFirestore.instance.collection("courses").where("course_name");
  final batch = FirebaseFirestore.instance.collection("batch").where("batch_year");
  final auth = FirebaseAuth.instance;

  int runTime = 0;
  NavigateToPage navigateToPage = NavigateToPage();

  late BuildContext thisPageContext;
  Widget userForm({BuildContext? context,int? index,bool approved=false}){
    thisPageContext = context!;
    this.index=index!;
    fetchBatch();
    fetchUserInfo();
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
                const Text("Update user",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 30,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Enter name",validate: (value){
                  if(!value!.isValidName){
                    return "Enter valid name";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: enroll,icon: Icons.abc_outlined,text: "Enter enroll",inputType: TextInputType.number,validate: (value){
                  if(value.toString().trim() == ""){
                    return "Enter valid enrollment";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    navigateToPage=value;
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
                CustomInputField().customInputField(readOnly: true,controller: email,icon: Icons.email_outlined,text: "Email",inputType: TextInputType.emailAddress,validate: (value){
                  if(!value!.isValidEmail){
                    return "Enter valid email";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: contact,icon: Icons.contact_page_outlined,text: "Contact no",inputType: TextInputType.number,validate: (value){
                  if(value.toString().trim() == ""){
                    return "Enter contact";
                  }
                  return null;
                }),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(readOnly: true,controller: password,icon: Icons.lock_outline,text: "Password",validate: (value){
                  if(!value!.isValidPassword){
                    return "Enter valid password";
                  }
                  return null;
                },obscureText: true),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Approve status"),
                        DropdownButton(items: approvalList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: approved?null:(val){ selectedApproval = val as String?; value.notifyListeners();},value: selectedApproval,),
                      ],
                    );
                  },
                ),

              ],
            ),
          ),
        ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Cancel")),
            ChangeNotifierProvider<ApprovedUserModel>(
              create: (context) => ApprovedUserModel(),
              child: Consumer<ApprovedUserModel>(
                builder: (context, value, child) {
                  return TextButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      if(selectedApproval == "Approved" && !approved){
                          value.updateUser(alertContext: context,approved: true,oldId: id, newId: auth.currentUser!.uid.toString(), context: thisPageContext, name: name.text.toString(), gender: gender.toString(), selectedCourse: selectedCourse.toString(), selectedBatch: selectedBatch.toString(), enroll: enroll.text.toString(), email: email.text.toString(), contact: contact.text.toString(), password: password.text.toString(), selectedApproval: selectedApproval.toString());
                      }else{
                        value.updateUser(alertContext: context,oldId: id, newId: auth.currentUser!.uid.toString(), context: thisPageContext, name: name.text.toString(), gender: gender.toString(), selectedCourse: selectedCourse.toString(), selectedBatch: selectedBatch.toString(), enroll: enroll.text.toString(), email: email.text.toString(), contact: contact.text.toString(), password: password.text.toString(), selectedApproval: selectedApproval.toString());
                      }
                    }
                  }, child: value.isLoading?const CircularProgressIndicator(): const Text("Update"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchUserInfo(){
      users.where("").get().then((QuerySnapshot snapshot){
        var data = snapshot.docs[index].data() as Map;
        id = data['id'].toString();
        name.text = data['name'].toString();
        enroll.text = data['enrollment'].toString();
        email.text = data['email'].toString();
        contact.text = data['contact'].toString();
        password.text = data['password'].toString();
        gender = data['gender'].toString();

        if(data['approved_status'] == '0'){
          selectedApproval = "Unapproved";
        }else{
          selectedApproval = "Approved";
        }
        selectedCourse = data['course'].toString();
        selectedBatch = data['batch'].toString();
      });
  }

  void fetchBatch() async{
    if(runTime==0){
      runTime = 1;
      batch.get().then((QuerySnapshot snapshot) {
        for (int i = 0; i < snapshot.size; i++) {
          var data = snapshot.docs[i].data() as Map;
          batchList.insert(i,data['batch_year']);
        }
      });
      courses.get().then((QuerySnapshot snapshot) {
        for (int i = 0; i < snapshot.size; i++) {
          var data = snapshot.docs[i].data() as Map;
          courseList.insert(i,data['course_name']);
        }
      });
      await Future.delayed(const Duration(milliseconds: 1000),(){
        navigateToPage.notifyListeners();
      });
    }
  }

}