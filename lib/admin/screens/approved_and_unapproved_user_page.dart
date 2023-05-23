import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/users_form.dart';

class UsersPage{
  bool approvedSelected = false;
  bool unapprovedSelected = false;

  final users = FirebaseFirestore.instance.collection("users").snapshots();

  Widget usersPage({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(approvedSelected == true ? "Approved users":"UnApproved users",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
        ),
        StreamBuilder<QuerySnapshot>(stream: users,
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return const Center(child: Center(child: Text("something went wrong")));
          }
          if(approvedSelected == true){
            return Expanded(
              child: ListView.builder(itemBuilder:(context, index) {
                if(snapshot.data!.docs[index]['approved_status'] != "0"){
                  return userListTile(context, snapshot, index);
                }
              },itemCount: snapshot.data!.docs.length,),
            );
          }else{
            return Expanded(
              child: ListView.builder(itemBuilder:(context, index) {
                if(snapshot.data!.docs[index]['approved_status'] != "1"){
                  return userListTile(context, snapshot, index);
                }
              },itemCount: snapshot.data!.docs.length,),
            );
          }
        },),
      ],
    );
  }

  Widget userListTile(BuildContext context,AsyncSnapshot snapshot,int index){
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person_2_outlined),),
      title: Text(snapshot.data!.docs[index]['name']),
      subtitle: Text(snapshot.data!.docs[index]['approved_status']),
      trailing: context!=null?IconButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return UserForm().userForm(context: context);
        });
      }, icon: const CircleAvatar(child: Icon(Icons.edit))):const Text(""),
    );
  }
}