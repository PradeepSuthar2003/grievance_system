import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/admin/forms/batch_form.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class AllBatchPage{
  bool isSelected = false;

  late BuildContext thisPageContext;

  final batch = FirebaseFirestore.instance.collection("batch");
  
  Widget allBatchPage({BuildContext? context}){
    thisPageContext = context!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("All batch",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
              RoundedButton().roundedButton(icon: Icons.add,radius: 20.0,onClick: (){
                context!=null?showDialog(context: context, builder: (context){
                    return BatchForm().batchForm(context: thisPageContext,isAddBatch: true);
                  }):const Text("");
              }),
            ],
          ),
        ),
        StreamBuilder(
          stream: batch.snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"),);
            }
          return Expanded(
            child: ListView.builder(itemBuilder:(context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text((index+1).toString()),),
                title: Text(snapshot.data!.docs[index]['batch_year']),
                subtitle: Text(snapshot.data!.docs[index]['datetime'].toString().substring(0,16)),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      CircleAvatar(child: IconButton(icon:const Icon(Icons.edit),onPressed: (){
                        context!=null?showDialog(context: context, builder: (context){
                          return BatchForm().batchForm(context: thisPageContext,id:snapshot.data!.docs[index]['id'],batchYear: snapshot.data!.docs[index]['batch_year']);
                        }):const Text("");
                      }),),
                      const SizedBox(width: 10,),
                      RoundedButton().roundedButton(radius: 20,color: Colors.red,icon: Icons.delete_forever_outlined,onClick: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: const Text("Do you want delete"),
                            actions: [
                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel")),
                              TextButton(onPressed: (){
                                batch.doc(snapshot.data!.docs[index]['id']).delete().then((value){
                                  ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Deleted");
                                }).onError((error, stackTrace){
                                  ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Something went wrong",ifError:true);
                                });
                                if(Navigator.canPop(context)){
                                  Navigator.pop(context);
                                }
                              }, child: const Text("Delete"))
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
        },),
      ],
    );
  }
}