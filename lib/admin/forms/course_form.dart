import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class CourseForm{
  TextEditingController courseName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget courseForm({BuildContext? context,bool isAddCourse = false}){
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
            CustomInputField().customInputField(controller: courseName,icon: Icons.abc_outlined,text: "Course",validate: (value){
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
          Navigator.pop(context!);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){
          if(_formKey.currentState!.validate()){

          }
        }, child:Text(isAddCourse?"Add":"Update"))
      ],
    );
  }
}