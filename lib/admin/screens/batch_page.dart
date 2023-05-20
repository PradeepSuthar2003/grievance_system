import 'package:flutter/material.dart';
import 'package:lj_grievance/admin/forms/batch_form.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class AllBatchPage{
  bool isSelected = false;
  Widget allBatchPage({BuildContext? context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("All batch",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
              RoundedButton().roundedButton(icon: Icons.add,radius: 20.0,onClick: (){
                context!=null?showDialog(context: context, builder: (context){
                    return BatchForm().batchForm(context: context,isAddBatch: true);
                  }):const Text("");
              }),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(itemBuilder:(context, index) {
            return ListTile(
              title: const Text("2022"),
              subtitle: const Text("time"),
              trailing: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    CircleAvatar(child: IconButton(icon:Icon(Icons.edit),onPressed: (){
                      context!=null?showDialog(context: context, builder: (context){
                        return BatchForm().batchForm(context: context);
                      }):const Text("");
                    }),),
                    const SizedBox(width: 10,),
                    const CircleAvatar(child: Icon(Icons.delete_forever_outlined),),
                  ],
                ),
              ),
            );
          },itemCount: 5,),
        ),
      ],
    );
  }
}