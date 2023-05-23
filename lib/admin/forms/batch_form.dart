import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/error_message.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class BatchForm{

  late BuildContext thisPageContext;

  final _formKey = GlobalKey<FormState>();
  TextEditingController batchYear = TextEditingController();
  
  final batch = FirebaseFirestore.instance.collection("batch");
  
  Widget batchForm({BuildContext? context,bool isAddBatch = false,String id="",String batchYear = ""}){
    this.batchYear.text = batchYear;
    thisPageContext = context!;
    return AlertDialog(title: Container(
      width: 400,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(isAddBatch?"Add batch":"Update batch",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
            const SizedBox(height: 30,),
            CustomInputField().customInputField(controller: this.batchYear,icon: Icons.abc_outlined,text: "batch",validate: (value){
              if((value!.trim()).isEmpty){
                return "Enter batch";
              }
              return null;
            }),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){
          if(_formKey.currentState!.validate()) {
            if(isAddBatch){
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              batch.doc(id).set({
                "batch_year":this.batchYear.text.toString(),
                "datetime":DateTime.now().toString(),
                "id":id
              }).then((value){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "new batch added");
              }).onError((error, stackTrace){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Something went wrong",ifError:true);
              });
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            }else{
              batch.doc(id).update({
                "batch_year":this.batchYear.text.toString(),
                "datetime":DateTime.now().toString()
              }).then((value){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "updated");
              }).onError((error, stackTrace){
                ErrorMessage().errorMessage(context: thisPageContext, errorMessage: "Something went wrong",ifError:true);
              });
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
            }
          }   
        }, child:Text(isAddBatch?"Add":"Update"))
      ],
    );
  }
}