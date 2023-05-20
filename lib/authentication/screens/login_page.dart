import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  List<String> usersType = ['Admin','Cell member','Student'];
  String? selectedUserType;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    selectedUserType = usersType[0];
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.35,),
              const Text("Login",style: TextStyle(fontSize: 40),),
              const SizedBox(height: 40,),
              CustomInputField().customInputField(icon: Icons.person_2_outlined, text: "Enter username", controller: email),
              const SizedBox(height: 15,),
              CustomInputField().customInputField(icon: Icons.lock_outline, text: "Enter password", controller: password),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Text("User type\t\t\t\t"),
                  Expanded(
                    child: DropdownButton(items: usersType.map((String item){
                      return DropdownMenuItem(value: item,child: Text(item));
                    }).toList(), onChanged: (val){selectedUserType = val;},value: selectedUserType,),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){}, child: const Text("Signup")),
                  RoundedButton().roundedButton(icon: Icons.arrow_forward_ios),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}