import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class MyGrievance{
  bool isSelected = false;

  List<String> grievanceType = ['College issue','other'];
  String? selectedGrievanceType;

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

  Widget myGrievance({BuildContext? context}){
    selectedGrievanceType = grievanceType[0];
    return Column(
      children: [
        Expanded(child:
          ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: const Text("Subject"),
              subtitle: const Text("details ..."),
              trailing: false?const Text("Open"):TextButton(child: const Text("View"),onPressed: (){
                showDialog(context: context, builder: (context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Container(
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Reply message",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                const Text("Grievance type : \t\t"),
                                Expanded(
                                  child: DropdownButton(items: grievanceType.map((String item){
                                    return DropdownMenuItem(value: item,child: Text(item));
                                  }).toList(), onChanged:null,value: selectedGrievanceType,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            CustomInputField().customInputField(icon: Icons.subject_outlined, text: 'Enter subject', controller: subject,readOnly: true),
                            const SizedBox(height: 10,),
                            CustomInputField().customInputField(icon: Icons.details, text: 'Enter details', controller: details,maxLines: 5,readOnly: true),
                            const SizedBox(height: 10,),
                            const Text("Reply",style: TextStyle(fontSize: 10),),
                            const Divider(),
                            const Text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",style: TextStyle(fontSize: 13),),
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
            );
          },itemCount: 5,),
        )
      ],
    );
  }
}