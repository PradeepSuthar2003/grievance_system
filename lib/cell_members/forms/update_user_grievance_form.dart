import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class UpdateUserGrievanceForm{

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
                CustomInputField().customInputField(controller: srNo,icon: Icons.abc_outlined,text: "Sr.no."),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: grievanceNo,icon: Icons.abc_outlined,text: "Gri.no"),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Grievance type"),
                        DropdownButton(items: grievanceTypeList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: (val){ selectedGrievanceType = val; value.notifyListeners();},value: selectedGrievanceType,),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: date,icon: Icons.abc_outlined,text: "Date"),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: subject,icon: Icons.abc_outlined,text: "Subject"),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: details,icon: Icons.abc_outlined,text: "Details",maxLines: 5),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: grievanceId,icon: Icons.abc_outlined,text: "Gri. Id"),
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
                            title: Column(
                              children: [
                                const Text("Reply"),
                                const SizedBox(height: 15,),
                                CustomInputField().customInputField(icon: Icons.abc_outlined, text: "Reply...", controller: reply,maxLines: 5),
                              ],
                            ),
                            actions:[
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  child:const Text("Cancel")),
                              TextButton(onPressed: () {},
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