import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';

class BatchForm{
  TextEditingController batchYear = TextEditingController();

  Widget batchForm({BuildContext? context,bool isAddBatch = false}){
    return AlertDialog(title: Container(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text(isAddBatch?"Add batch":"Update batch",style: const TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
          const SizedBox(height: 30,),
          CustomInputField().customInputField(controller: batchYear,icon: Icons.abc_outlined,text: "batch"),
          const SizedBox(height: 15,),
        ],
      ),
    ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context!);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){}, child:Text(isAddBatch?"Add":"Update"))
      ],
    );
  }
}