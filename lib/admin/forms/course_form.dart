import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class CourseForm{

  late BuildContext thisPageContext;

  TextEditingController courseName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final course = FirebaseFirestore.instance.collection("courses");

  Widget courseForm({BuildContext? context,bool isAddCourse = false,var id,String courseName=""}){
    this.courseName.text = courseName;
    thisPageContext = context!;
    return AlertDialog(title: Container(
      width: 400,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(isAddCourse?"Add course":"Update course",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
            const SizedBox(height: 30,),
            CustomInputField().customInputField(controller: this.courseName,icon: Icons.abc_outlined,text: "Course",validate: (value){
              if((value!.trim()).isEmpty){
                return "Enter batch";
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
          Navigator.pop(context);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            if(isAddCourse){
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              course.doc(id).set({
                "course_name":this.courseName.text.toString(),
                "datetime":DateTime.now().toString(),
                "id":id
              }).then((value){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "new course added");
              }).onError((error, stackTrace){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Something went wrong",ifError:true);
              });
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            }else{
              course.doc(id).update({
                "course_name":this.courseName.text.toString(),
                "datetime":DateTime.now().toString(),
              }).then((value){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "updated");
              }).onError((error, stackTrace){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Something went wrong",ifError:true);
              });
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            }
          }
        }, child:Text(isAddCourse?"Add":"Update"))
      ],
    );
  }
}