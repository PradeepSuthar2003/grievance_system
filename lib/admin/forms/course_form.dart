import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class CourseForm{
  TextEditingController courseName = TextEditingController();

  Widget courseForm({BuildContext? context,bool isAddCourse = false}){
    return AlertDialog(title: Container(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text(isAddCourse?"Add course":"Update course",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
          const SizedBox(height: 30,),
          CustomInputField().customInputField(controller: courseName,icon: Icons.abc_outlined,text: "Course"),
          const SizedBox(height: 15,),
        ],
      ),
    ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context!);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){}, child:Text(isAddCourse?"Add":"Update"))
      ],
    );
  }
}