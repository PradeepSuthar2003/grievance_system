import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class PostNewGrievance with ChangeNotifier{
  bool isSelected = false;

  final _postNewGrievanceFormKey = GlobalKey<FormState>();

  List<String> grievanceType = ['College issue','other'];
  String? selectedGrievanceType;

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

  Widget postNewGrievance({BuildContext? context}){
    selectedGrievanceType = grievanceType[0];
    return SingleChildScrollView(
      child: ChangeNotifierProvider<NavigateToPage>(
        create: (context) => NavigateToPage(),
        child: Form(
          key: _postNewGrievanceFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Post new grievance",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const Text("Grievance type : \t\t"),
                    Expanded(
                      child: Consumer<NavigateToPage>(builder: (context, value, child) {
                        return DropdownButton(items: grievanceType.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item));
                        }).toList(), onChanged: (val){ selectedGrievanceType = val; value.notifyListeners(); },value: selectedGrievanceType,);
                      },),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomInputField().customInputField(icon: Icons.subject_outlined, text: 'Enter subject', controller: subject,validate: (value){
                  if((value!.trim()).isEmpty){
                    return "Enter subject";
                  }
                  return null;
                }),
                const SizedBox(height: 10,),
                CustomInputField().customInputField(icon: Icons.details, text: 'Enter details', controller: details,maxLines: 5,validate: (value){
                  if((value!.trim()).isEmpty){
                    return "Enter details";
                  }
                  return null;
                }),
                const SizedBox(height: 20,),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Submit"),
                    RoundedButton().roundedButton(icon: Icons.chevron_right_sharp,onClick: (){
                      if(_postNewGrievanceFormKey.currentState!.validate()){}
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}