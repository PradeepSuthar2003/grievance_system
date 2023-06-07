import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/navigate_to_page.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class Dashboard{
  bool isSelected = false;
  final allGrievance = FirebaseFirestore.instance.collection("grievances");
  int runTime = 0;
  List<String> grievanceType = [];
  NavigateToPage navigateToPage = NavigateToPage();

  List<TextEditingController> controllerList = [];

  Widget showDashboard({BuildContext? context}){
    fetchGrievanceType();
    return ChangeNotifierProvider(
      create: (context) => NavigateToPage(),
      child: Consumer<NavigateToPage>(
        builder: (context, value, child) {
          navigateToPage = value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dashboard",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline,color: Color(0xFF033500)),),
                    RoundedButton().roundedButton(icon: Icons.refresh,radius: 20,onClick: (){
                      navigateToPage.notifyListeners();
                    })
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  getCount(grievanceType[index],index);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomInputField().customInputField(readOnly: true,themeColor: const Color(0xFF033500),haveLabel: true,labelText: grievanceType[index],icon: Icons.request_page_outlined, text: "", controller: controllerList[index]),
                  );
                },itemCount: grievanceType.length,),
              ),
            ],
          );
        },
      ),
    );
  }

  void getCount(String grievanceType,int index){
    allGrievance.where("grievance_type",isEqualTo: grievanceType).count().get().then((value){
      controllerList[index].text = value.count.toString();
    }).onError((error, stackTrace){
      controllerList[index].text = "Something want wrong";
    });
  }

  void fetchGrievanceType(){
    if(runTime==0){
      runTime++;
      FirebaseFirestore.instance.collection("grievance_type").where("").get().then((QuerySnapshot snapshot){
        for(int i=0;i<snapshot.size;i++){
          var data = snapshot.docs[i].data() as Map;
          grievanceType.add(data['grievance_type']);
          controllerList.add(TextEditingController(text: data['grievance_type']));
        }
      }).then((value){
        navigateToPage.notifyListeners();
      });
    }
  }

}