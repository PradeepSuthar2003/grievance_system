import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/users_form.dart';

class UsersPage{
  bool approvedSelected = false;
  bool unapprovedSelected = false;
  Widget usersPage({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(approvedSelected == true ? "Approved users":"UnApproved users",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
        ),
        Expanded(
          child: ListView.builder(itemBuilder:(context, index) {
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_2_outlined),),
              title: const Text("Username"),
              subtitle: const Text("Status - approved"),
              trailing: context!=null?IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return UserForm().userForm(context: context);
                });
              }, icon: const CircleAvatar(child: Icon(Icons.edit))):const Text(""),
            );
          },itemCount: 5,),
        ),
      ],
    );
  }
}