import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/authentication/screens/session.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/models/post_new_grievance_model.dart';
import 'package:provider/provider.dart';

class PostNewGrievance with ChangeNotifier{
  bool isSelected = false;

  final _postNewGrievanceFormKey = GlobalKey<FormState>();

  final postGrievance = FirebaseFirestore.instance.collection("grievances");

  List<String> grievanceType = [];
  String? selectedGrievanceType;

  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

  int runTime = 0;

  Widget postNewGrievance({BuildContext? context}){
    fetchGrievanceType();
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
                ChangeNotifierProvider<PostNewGrievanceModel>(
                  create: (context) => PostNewGrievanceModel(),
                  child: Consumer<PostNewGrievanceModel>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Submit"),
                          RoundedButton().roundedButton(haveTwoChild: value.isLoading,child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),icon: Icons.chevron_right_sharp,onClick: (){
                            if(_postNewGrievanceFormKey.currentState!.validate()){
                              value.postGrievanceMessage(context: context,selectedGrievanceType: selectedGrievanceType,details: details.text.toString(),subject: subject.text.toString());
                              emptyForm();
                            }
                          })
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void fetchGrievanceType(){
    if(runTime==0){
      runTime++;
      FirebaseFirestore.instance.collection("grievance_type").where("").get().then((QuerySnapshot snapshot){
        for(int i=0;i<snapshot.size;i++){
          var data = snapshot.docs[i].data() as Map;
          grievanceType.add(data['grievance_type']);
        }
        selectedGrievanceType = grievanceType[0];
      }).then((value){
      });
    }
  }

  void emptyForm()async{
    await Future.delayed(const Duration(seconds: 1),() {
      subject.text = "";
      details.text = "";
    },);
  }
}