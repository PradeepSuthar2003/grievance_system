import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class UpdateUserGrievanceForm{

  final _replyFormKey = GlobalKey<FormState>();

  List<String> grievanceTypeList = ['Issue about college','BCA'];
  String? selectedGrievanceType;

  List<String> statusList = ['Open','Close'];
  String? selectedStatus;


  TextEditingController srNo = TextEditingController();
  TextEditingController grievanceNo = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController grievanceId = TextEditingController();
  TextEditingController reply = TextEditingController();

  Widget updateUserGrievanceForm({BuildContext? context}){
    selectedGrievanceType = grievanceTypeList[0];
    selectedStatus = statusList[1];

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
                const Text("Update user",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 30,),
                CustomInputField().customInputField(controller: srNo,icon: Icons.abc_outlined,text: "Sr.no.",readOnly: true),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: grievanceNo,icon: Icons.abc_outlined,text: "Gri.no",readOnly: true),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Grievance type"),
                    DropdownButton(items: grievanceTypeList.map((String item){
                      return DropdownMenuItem(value: item,child: Text(item),);
                    }).toList(), onChanged:null,value: selectedGrievanceType,),
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status"),
                        DropdownButton(items: statusList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: (val){ selectedStatus = val; value.notifyListeners();},value: selectedStatus,),
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
                                  CustomInputField().customInputField(icon: Icons.abc_outlined, text: "Reply...", controller: reply,maxLines: 5,validate: (value){
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
                              TextButton(onPressed: () {
                                if(_replyFormKey.currentState!.validate()){}
                              },
                            child:const Text("Reply"))
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
                    TextButton(onPressed: (){}, child: const Text("Update"))
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
}