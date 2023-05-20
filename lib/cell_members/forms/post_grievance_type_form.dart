import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class PostGrievanceTypeForm{
  TextEditingController grievanceType = TextEditingController();

  Widget postGrievanceForm(){
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Add grievance type",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
            ),
            CustomInputField().customInputField(icon: Icons.select_all_outlined, text: "Enter grievance type", controller: grievanceType),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){},style: ButtonStyle(elevation: MaterialStateProperty.all(0.0)), child: const Text("Add")),
            const SizedBox(height: 10,),
            const Divider(),
            const Text("All grievance type"),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("Grievance type"),
                  trailing: Text("Added date"),
                );
              },itemCount: 5,),
            )
          ],
        ),
      ),
    );
  }
}