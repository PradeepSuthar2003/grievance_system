import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/add_or_update_grievance_form.dart';

class AllGrievance{
  bool isSelected = true;
  Widget allGrievance({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("All grievance cell members",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
        ),
        Expanded(
          child: ListView.builder(itemBuilder:(context, index) {
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_2_outlined),),
              title: const Text("Name"),
              subtitle: const Text("email"),
              trailing: context!=null?IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AdUpGrievanceForm().adUpGrievanceForm(context: context);
                });
              }, icon: const CircleAvatar(child: Icon(Icons.edit))):const Text(""),
            );
          },itemCount: 5,),
        ),
      ],
    );
  }
}