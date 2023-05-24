import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class UpdateUserGrievanceForm{

  final _replyFormKey = GlobalKey<FormState>();

  List<String> statusList = ['Open','Close'];
  String? selectedStatus;

  String selectedGrievanceType = "";

  final grievance = FirebaseFirestore.instance.collection("grievances");

  TextEditingController srNo = TextEditingController();
  TextEditingController grievanceNo = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController grievanceId = TextEditingController();
  TextEditingController reply = TextEditingController();

  NavigateToPage navigateToPage = NavigateToPage();

  Widget updateUserGrievanceForm({BuildContext? context,String? id}){
    fetchGrievanceInfo(id!);
    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Grievance type"),
                    Text(selectedGrievanceType),
                  ],
                ),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: date,icon: Icons.abc_outlined,text: "Date",readOnly: true),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: subject,icon: Icons.abc_outlined,text: "Subject",readOnly: true),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: details,icon: Icons.abc_outlined,text: "Details",maxLines: 5,readOnly: true),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: grievanceId,icon: Icons.abc_outlined,text: "Gri. Id",readOnly: true),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    navigateToPage = value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status"),
                        DropdownButton(items: statusList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: reply.text == "0"?(val){ selectedStatus = val as String?; value.notifyListeners();}:null,value: selectedStatus,),
                      ],
                    );
                  },
                ),
                Row(
                  children:[
                    TextButton(onPressed: (){
                      context!=null?showDialog(context: context, builder: (context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: Form(
                              key: _replyFormKey,
                              child: Column(
                                children: [
                                  const Text("Reply"),
                                  const SizedBox(height: 15,),
                                  CustomInputField().customInputField(readOnly: reply.text == "0"?false:true,icon: Icons.abc_outlined, text: "Reply...", controller: reply,maxLines: 5,validate: (value){
                                    if((value!.trim()).isEmpty){
                                      return "Enter reply";
                                    }
                                    return null;
                                  }),
                                ],
                              ),
                            ),
                            actions:[
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  child:const Text("Cancel")),
                              reply.text == "0" ? TextButton(onPressed: () {
                                if(_replyFormKey.currentState!.validate()){
                                  giveReply(id);
                                }
                              },
                            child:const Text("Reply")):Container(),
                            ],
                          ),
                        );
                      },):const Text("");
                    }, child: const Text("Reply now"))
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pop(context!);
                    }, child: const Text("Cancel")),
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),
        ),
    );
  }
  
  void fetchGrievanceInfo(String id){
    grievance.doc(id).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        var data = snapshot.data() as Map;
        selectedGrievanceType = data['grievance_type'];
        if(data['status'] == "0"){
          selectedStatus = statusList[0];
        }else{
          selectedStatus = statusList[1];
        }
        reply.text = data['reply'];
        subject.text = data['subject'];
        grievanceId.text = data['id'];
        date.text = data['date'];
        details.text = data['details'];
      }
    }).then((value){
      navigateToPage.notifyListeners();
    });
  }

  void giveReply(String id){
    grievance.doc(id).update({
      "reply":reply.text.toString(),
      "status":"1",
    }).then((value) {
    });
  }
}