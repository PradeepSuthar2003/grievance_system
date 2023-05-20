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
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(),
              title: const Text("Subject"),
              subtitle: const Text("Student name"),
              trailing: TextButton(onPressed: (){
                Navigator.pushNamed(context, 'update_user_grievance_page');
              }, child: const Text("View more"),),
            );
          },itemCount: 5,),
        ),
      ],
    );
  }
}