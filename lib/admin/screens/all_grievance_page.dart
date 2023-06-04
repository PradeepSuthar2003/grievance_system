import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/add_or_update_grievance_form.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class AllGrievance{
  bool isSelected = true;
  final memberUser = FirebaseFirestore.instance.collection("users");

  Widget allGrievance({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("All grievance cell members",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
        ),
        StreamBuilder(
          stream: memberUser.snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"),);
            }

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            return Expanded(
            child: ListView.builder(itemBuilder:(context, index) {
              if(snapshot.data!.docs[index]['approved_status'] == "2"){
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person_2_outlined),),
                  title: Text(snapshot.data!.docs[index]['name']),
                  subtitle: Text(snapshot.data!.docs[index]['email']),
                  trailing: SizedBox(
                    width:100,
                    child: Row(
                      children: [
                        context!=null?IconButton(onPressed: (){
                          showDialog(context: context, builder: (context){
                            return AdUpGrievanceForm().adUpGrievanceForm(context: context,index: index);
                          });
                        }, icon: const CircleAvatar(child: Icon(Icons.edit))):const Text(""),
                        // RoundedButton().roundedButton(icon: Icons.delete_forever_outlined,color: Colors.red,radius: 20,onClick: (){
                        // }),
                      ],
                    ),
                  ),
                );
              }else{
                return Container();
              }
            },itemCount: snapshot.data!.docs.length,),
          );
        },),
      ],
    );
  }
}