import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class MyGrievance{
  bool isSelected = true;

  final postGrievance = FirebaseFirestore.instance.collection("grievances");
  final auth = FirebaseAuth.instance;

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

  Widget myGrievance({BuildContext? context}){
    return Column(
      children: [
        StreamBuilder(
        stream: postGrievance.orderBy("id",descending:true).snapshots(),
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
                trailing: snapshot.data!.docs[index]['reply'] == "0"?const Text("Open\t\t\t\t\t\t\t"):SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      TextButton(child: const Text("View"),onPressed: (){
                        subject.text = snapshot.data!.docs[index]['subject'];
                        details.text = snapshot.data!.docs[index]['details'];
                        showDialog(context: context, builder: (context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: SizedBox(
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Reply message",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        const Text("Grievance type : \t\t\t",style: TextStyle(fontSize: 15),),
                                        Text(snapshot.data!.docs[index]['grievance_type'],style: const TextStyle(fontSize: 15),),
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
                      RoundedButton().roundedButton(icon: Icons.delete_forever_outlined,color: Colors.red,radius: 20,onClick: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(title: const Text("Do you want to delete ?"),actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text("Cancel")),
                            TextButton(onPressed: (){
                              postGrievance.doc(snapshot.data!.docs[index]['id']).delete();
                              Navigator.pop(context);
                            }, child: const Text("Delete")),
                          ],);
                        },);
                      }),
                    ],
                  ),
                ),
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