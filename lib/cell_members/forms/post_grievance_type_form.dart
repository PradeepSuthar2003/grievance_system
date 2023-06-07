import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/vaildation/validation.dart';

class PostGrievanceTypeForm{

  final _postGrievanceFormKey = GlobalKey<FormState>();

  TextEditingController grievanceType = TextEditingController();

  final grievanceTypeCollection = FirebaseFirestore.instance.collection("grievance_type");

  Widget postGrievanceForm(){
    return Form(
      key: _postGrievanceFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text("Add grievance type",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Color(0xFF033500)),),
            ),
            CustomInputField().customInputField(icon: Icons.select_all_outlined, text: "Enter grievance type", controller: grievanceType,validate: (value){
              if((value!.trim()).isEmpty){
                return "Enter grievance type";
              }
              return null;
              }),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              if(_postGrievanceFormKey.currentState!.validate()){
                postGrievanceType();
              }
            },style: ButtonStyle(elevation: MaterialStateProperty.all(0.0)), child: const Text("Add")),
            const SizedBox(height: 10,),
            const Divider(),
            const Text("All grievance type"),
            const SizedBox(height: 10,),
            StreamBuilder(
              stream: grievanceTypeCollection.snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return const Center(child: Text("Something went wrong"));
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]['grievance_type']),
                      subtitle: Text(snapshot.data!.docs[index]['date'].toString().substring(0,16)),
                      trailing: RoundedButton().roundedButton(icon: Icons.delete_forever_outlined,radius: 20,color: Colors.red,onClick: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: const Text("Do you want to delete ?"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("Cancel")),
                              TextButton(onPressed: (){
                                grievanceTypeCollection.doc(snapshot.data!.docs[index]['id']).delete();
                                Navigator.pop(context);
                              }, child: const Text("Delete")),
                            ],
                          );
                        },);
                      }),
                    );
                  },itemCount: snapshot.data!.docs.length,),
                );
            },),
          ],
        ),
      ),
    );
  }

  void postGrievanceType(){
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    grievanceTypeCollection.doc(id).set({
      "id":id,
      "grievance_type":grievanceType.text.toString(),
      "date":DateTime.now().toString()
    }).then((value){
      grievanceType.text = "";
    });
  }
}