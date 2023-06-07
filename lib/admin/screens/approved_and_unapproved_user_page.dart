import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/users_form.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

final users = FirebaseFirestore.instance.collection("users");

class UsersPage{
  bool approvedSelected = false;
  bool unapprovedSelected = false;

  late BuildContext thisPageContext;

  Widget usersPage({BuildContext? context,bool approvedSelect = false}){
    thisPageContext = context!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(approvedSelected == true ? "Approved users":"UnApproved users",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Color(0xFF033500)),),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return const Center(child: Center(child: Text("something went wrong")));
          }
          if(approvedSelect){
            return Expanded(
              child: ListView.builder(itemBuilder:(context, index) {
                if(snapshot.data!.docs[index]['approved_status'] == "1"){
                  return userListTile(context, snapshot, index,approvedSelect);
                }
                return Container();
              },itemCount: snapshot.data!.docs.length,),
            );
          }else{
            return Expanded(
              child: ListView.builder(itemBuilder:(context, index) {
                if(snapshot.data!.docs[index]['approved_status'] == "0"){
                  return userListTile(context, snapshot, index,approvedSelect);
                }
                return Container();
              },itemCount: snapshot.data!.docs.length,),
            );
          }
        },),
      ],
    );
  }

  Widget userListTile(BuildContext context,AsyncSnapshot snapshot,int index,bool approval){
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person_2_outlined),),
      title: Text(snapshot.data!.docs[index]['name']),
      subtitle: Text((snapshot.data!.docs[index]['approved_status']!="0")?"Approved":"Unapproved"),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            context!=null?RoundedButton().roundedButton(radius: 20,icon: Icons.edit,onClick: (){
              showDialog(context: context, builder: (context){
                return UserForm().userForm(context: thisPageContext,index:index,approved:approvedSelected);
              });
            }):const Text(""),
            !approval?
            RoundedButton().roundedButton(icon: Icons.delete_forever_outlined,color: Colors.red,radius: 20,onClick: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title:const Text("Do you want to delete"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Cancel")),
                    TextButton(onPressed: (){
                      users.doc(snapshot.data!.docs[index]['id']).delete();
                      Navigator.pop(context);
                    }, child: const Text("Delete")),
                  ],
                );
              });
            }):Container(),
          ],
        ),
      ),
    );
  }
}