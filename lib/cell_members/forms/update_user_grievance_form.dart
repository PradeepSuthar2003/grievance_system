import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class UpdateUserGrievanceForm{

  List<String> courseList = ['MCA','BCA'];
  String? selectedCourse;

  List<String> batchList = ['2018','2019'];
  String? selectedBatch;

  List<String> approvalList = ['Approved','Unapproved'];
  String? selectedApproval;

  TextEditingController enroll = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController replyMessage = TextEditingController();

  Widget updateUserGrievanceForm({BuildContext? context}){
    selectedCourse = courseList[0];
    selectedBatch = batchList[0];
    selectedApproval = approvalList[0];

    return ChangeNotifierProvider<NavigateToPage>(
      create: (context) => NavigateToPage(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Text("Update user",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Colors.blueAccent),),
                const SizedBox(height: 30,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Sr.no."),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Gri.no"),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Grievance type"),
                        DropdownButton(items: courseList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: (val){ selectedCourse = val; value.notifyListeners();},value: selectedCourse,),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Date"),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Subject"),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Details",maxLines: 5),
                const SizedBox(height: 15,),
                CustomInputField().customInputField(controller: name,icon: Icons.abc_outlined,text: "Gri. Id"),
                const SizedBox(height: 15,),
                Consumer<NavigateToPage>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status"),
                        DropdownButton(items: batchList.map((String item){
                          return DropdownMenuItem(value: item,child: Text(item),);
                        }).toList(), onChanged: (val){ selectedBatch = val; value.notifyListeners();},value: selectedBatch,),
                      ],
                    );
                  },
                ),
                Row(
                  children:[
                    TextButton(onPressed: (){
                      context!=null?showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              const Text("Reply"),
                              const SizedBox(height: 15,),
                              CustomInputField().customInputField(icon: Icons.abc_outlined, text: "Reply...", controller: replyMessage,maxLines: 5),
                            ],
                          ),
                          actions:[TextButton(onPressed: () {},
                          child:const Text("Reply"))],
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