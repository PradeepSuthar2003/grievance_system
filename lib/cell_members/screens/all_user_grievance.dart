import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class AllUserGrievance{
  bool isSelected = true;
  final allGrievance = FirebaseFirestore.instance.collection("grievances");

  Widget allUserGrievance({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("All grievance message",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Color(0xFF033500)),),
        ),
        StreamBuilder(
          stream: allGrievance.orderBy("status").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Expanded(
            child: ListView.builder(itemBuilder: (context, index) {

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.error_outline_outlined),),
                title: Text(snapshot.data!.docs[index]['subject']),
                subtitle: Text(snapshot.data!.docs[index]['details']),
                trailing: SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, 'update_user_grievance_page',arguments: snapshot.data!.docs[index]['id']);
                      }, child: snapshot.data!.docs[index]['status']=="1"?const Text("View"):const SizedBox(width: 30,child: Text("* New",style: TextStyle(color: Colors.red),)),),
                      RoundedButton().roundedButton(icon: Icons.delete_forever_outlined,color: Colors.red,radius: 20,onClick: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(title: const Text("Do you want to delete ?"),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: const Text("Cancel")),
                            TextButton(onPressed: () {
                              allGrievance.doc(snapshot.data!.docs[index]['id']).delete();
                              Navigator.pop(context);
                            }, child: const Text("Delete")),
                          ],
                          );
                        },);
                      }),
                    ],
                  ),
                ),
              );
            },itemCount: snapshot.data!.docs.length,),
          );
        },)
      ],
    );
  }
}