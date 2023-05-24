import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class MyGrievance{
  bool isSelected = false;

  final postGrievance = FirebaseFirestore.instance.collection("grievances");
  final auth = FirebaseAuth.instance;

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

  Widget myGrievance({BuildContext? context}){
    return Column(
      children: [
        StreamBuilder(
        stream: postGrievance.snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Expanded(child:
          ListView.builder(itemBuilder: (context, index) {
            if(snapshot.data!.docs[index]['user_id'] == Session().userId){
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.report_gmailerrorred_outlined),),
                title: Text(snapshot.data!.docs[index]['subject']),
                subtitle: Text(snapshot.data!.docs[index]['details']),
                trailing: snapshot.data!.docs[index]['reply'] == "0"?const Text("Open"):TextButton(child: const Text("View"),onPressed: (){
                  showDialog(context: context, builder: (context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        title: Container(
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Reply message",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  const Text("Grievance type : \t\t"),
                                  Text(snapshot.data!.docs[index]['grievance_type']),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              CustomInputField().customInputField(icon: Icons.subject_outlined, text: 'Enter subject', controller: subject,readOnly: true),
                              const SizedBox(height: 10,),
                              CustomInputField().customInputField(icon: Icons.details, text: 'Enter details', controller: details,maxLines: 5,readOnly: true),
                              const SizedBox(height: 10,),
                              const Text("Reply",style: TextStyle(fontSize: 10),),
                              const Divider(),
                              Text(snapshot.data!.docs[index]['reply']=="0"?"":snapshot.data!.docs[index]['reply'],style: const TextStyle(fontSize: 13),),
                              const SizedBox(height: 20,),
                              const Divider(),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              },child:const Text("Cancel")),
                            ],
                          ),
                        ),
                      ),
                    );
                  },);
                }),
              );
            }
            return Container();
          },itemCount: snapshot.data!.docs.length,),
          );
        },),
      ],
    );
  }
}