import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUserGrievance{
  bool isSelected = true;
  Widget allUserGrievance({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("All grievance message",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("grievances").snapshots(),
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
                trailing: TextButton(onPressed: (){
                  Navigator.pushNamed(context, 'update_user_grievance_page',arguments: snapshot.data!.docs[index]['id']);
                }, child: const Text("View more"),),
              );
            },itemCount: snapshot.data!.docs.length,),
          );
        },)
      ],
    );
  }
}