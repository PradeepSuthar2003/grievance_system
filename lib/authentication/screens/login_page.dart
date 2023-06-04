import 'package:flutter/material.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/models/login_model.dart';
import 'package:lj_grievance/vaildation/validation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  final _loginForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: RichText(text: const TextSpan(text: "Welcome to ",style: TextStyle(color: Colors.white70,fontSize: 20),children: [
            TextSpan(text: "\tGrievance System",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10))
          ])),
          elevation: 0,
          backgroundColor: const Color(0xFF1C2E4A),
        ),
        backgroundColor: const Color(0xFF1C2E4A),
        body: SingleChildScrollView(
          child: Form(
            key: _loginForm,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: MediaQuery.of(context).size.height * 0.18),
              child: Container(
                width: 400,
                height: 430,
                decoration: const BoxDecoration(
                  color: Color(0xFF152238),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Login",style: TextStyle(fontSize: 40,color: Colors.white),),
                      const SizedBox(height: 50,),
                      CustomInputField().customInputField(inputType: TextInputType.emailAddress,themeColor: Colors.white,icon: Icons.person_2_outlined, text: "Enter username", controller: email,validate: (value){
                        if(!value!.isValidEmail){
                          return "Enter valid email";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20,),
                      Consumer<LoginModel>(
                        builder: (context, value, child) {
                          return CustomInputField().customInputField(passwordShowIcon: Icons.remove_red_eye_outlined,themeColor: Colors.white,icon: Icons.lock_outline, text: "Enter password", obscureText: value.isPasswordNotVisible,postIcon: Icons.remove_red_eye,postIconClicked: (){
                            if(value.isPasswordNotVisible){
                              value.isPasswordNotVisible=false;
                              value.notifyListeners();
                            }else{
                              value.isPasswordNotVisible=true;
                              value.notifyListeners();
                            }
                          },controller: password,validate: (value){
                            if(!value!.isValidPassword){
                              return "Enter valid password";
                            }
                            return null;
                          });
                        },
                      ),
                      const SizedBox(height: 20,),
                      const Divider(),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.pushNamedAndRemoveUntil(context, 'signup_page', (route) => false);
                          }, child: const Text("Signup",style: TextStyle(color: Colors.white),)),
                          Consumer<LoginModel>(
                            builder: (context, value, child) {
                              return RoundedButton().roundedButton(icon: Icons.arrow_forward_ios,haveTwoChild: value.isLoading,color:Colors.indigo,child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),onClick: (){
                                if(_loginForm.currentState!.validate()){
                                  value.login(context: context,email: email.text.toString(), password: password.text.toString());
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}