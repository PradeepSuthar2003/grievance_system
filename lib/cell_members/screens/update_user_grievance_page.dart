import 'package:flutter/material.dart';
import 'package:lj_grievance/cell_members/forms/update_user_grievance_form.dart';

class UpdateUserGrievancePage extends StatefulWidget{
  const UpdateUserGrievancePage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateUserGrievancePage();
}

class _UpdateUserGrievancePage extends State<UpdateUserGrievancePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(text: const TextSpan(text: "Cell Member",children: [
          TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
        ])),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              child: IconButton(onPressed: (){
              }, icon: const Icon(Icons.person_2_outlined,color: Colors.white,)),
            ),
          )
        ],
      ),
      body: UpdateUserGrievanceForm().updateUserGrievanceForm(context: context),
    );
  }
}