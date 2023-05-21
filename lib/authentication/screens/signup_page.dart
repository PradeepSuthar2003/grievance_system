import 'package:flutter/material.dart';
import 'package:lj_grievance/Utils/gender_group.dart';
import 'package:lj_grievance/custom_widgets/custom_input_field.dart';
import 'package:lj_grievance/custom_widgets/rounded_button.dart';
import 'package:lj_grievance/models/signup_model.dart';
import 'package:lj_grievance/vaildation/validation.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  Gender? gender = Gender.Male;

  List<String> courseTypeList = ['MCA', 'BCA', 'IMCA'];
  String selectedCourseTypeList = "";

  List<String> batchTypeList = ['2022', '2019', '2020'];
  String selectedBatchTypeList = "";

  TextEditingController email = TextEditingController();
  TextEditingController enrollmentNo = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  final _signupForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    selectedCourseTypeList = courseTypeList[0];
    selectedBatchTypeList = batchTypeList[0];

    return ChangeNotifierProvider<SignUpModel>(
      create: (context) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
              text: const TextSpan(
                  text: "Welcome to ",
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  children: [
                TextSpan(
                    text: "\tGrievance System",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10))
              ])),
          elevation: 0,
          backgroundColor: const Color(0xFF1C2E4A),
        ),
        backgroundColor: const Color(0xFF1C2E4A),
        body: SingleChildScrollView(
          child: Form(
            key: _signupForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                height: 900,
                decoration: const BoxDecoration(
                  color: Color(0xFF152238),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Signup",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomInputField().customInputField(
                          inputType: TextInputType.name,
                          themeColor: Colors.white,
                          icon: Icons.person_2_outlined,
                          text: "Enter name",
                          controller: name,
                          validate: (value) {
                            if (!value!.isValidName) {
                              return "Enter valid name";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<SignUpModel>(
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              const Text(
                                "Gender",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              RadioMenuButton(
                                  value: Gender.Male,
                                  groupValue: gender,
                                  onChanged: (val) {
                                    gender = val;
                                    value.notifyListeners();
                                  },
                                  child: const Text(
                                    "Male",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  )),
                              RadioMenuButton(
                                  value: Gender.Female,
                                  groupValue: gender,
                                  onChanged: (val) {
                                    gender = val;
                                    value.notifyListeners();
                                  },
                                  child: const Text(
                                    "Female",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  )),
                              RadioMenuButton(
                                  value: Gender.Other,
                                  groupValue: gender,
                                  onChanged: (val) {
                                    gender = val;
                                    value.notifyListeners();
                                  },
                                  child: const Text(
                                    "Other",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  )),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<SignUpModel>(
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              const Text(
                                "Course\t\t\t\t",
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: DropdownButton(
                                  dropdownColor: const Color(0xFF152238),
                                  items: courseTypeList.map((String item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedCourseTypeList = val!;
                                    value.notifyListeners();
                                  },
                                  value: selectedCourseTypeList,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<SignUpModel>(
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              const Text(
                                "Batch\t\t\t\t",
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                child: DropdownButton(
                                  dropdownColor: const Color(0xFF152238),
                                  items: batchTypeList.map((String item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedBatchTypeList = val!;
                                    value.notifyListeners();
                                  },
                                  value: selectedBatchTypeList,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInputField().customInputField(
                          inputType: TextInputType.number,
                          themeColor: Colors.white,
                          icon: Icons.join_inner_outlined,
                          text: "Enrollment",
                          controller: enrollmentNo,
                          validate: (value) {
                            if (!value!.isNotNull) {
                              return "Enter enrollment";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInputField().customInputField(
                          inputType: TextInputType.emailAddress,
                          themeColor: Colors.white,
                          icon: Icons.email_outlined,
                          text: "Enter email",
                          controller: email,
                          validate: (value) {
                            if (!value!.isValidEmail) {
                              return "Enter valid email";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInputField().customInputField(
                          inputType: TextInputType.number,
                          themeColor: Colors.white,
                          icon: Icons.contact_page_outlined,
                          text: "Enter contact",
                          controller: contact,
                          validate: (value) {
                            if (!value!.isNotNull) {
                              return "Enter contact";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<SignUpModel>(
                        builder: (context, value, child) {
                          return CustomInputField().customInputField(
                              themeColor: Colors.white,
                              icon: Icons.lock_outline,
                              passwordShowIcon: Icons.remove_red_eye_outlined,
                              postIcon: Icons.remove_red_eye,
                              text: "Enter password",
                              obscureText: value.isPasswordNotVisible,
                              controller: password,
                              validate: (value) {
                                if (!value!.isValidPassword) {
                                  return "Enter valid password";
                                }
                                return null;
                              },postIconClicked: (){
                                if(value.isPasswordNotVisible){
                                  value.isPasswordNotVisible = false;
                                  value.notifyListeners();
                                }else{
                                  value.isPasswordNotVisible = true;
                                  value.notifyListeners();
                                }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<SignUpModel>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context, 'login_page', (route) => false);
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              RoundedButton().roundedButton(
                                  haveTwoChild: value.isLoading,
                                  child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white)),
                                  icon: Icons.arrow_forward_ios,
                                  onClick: () {
                                    if (_signupForm.currentState!.validate()) {
                                      value.signUp(
                                          context: context,
                                          name: name.text.toString(),
                                          gender: gender.toString().substring(7),
                                          course: selectedCourseTypeList,
                                          batch: selectedBatchTypeList,
                                          enroll: enrollmentNo.text.toString(),
                                          email: email.text.toString(),
                                          contact: contact.text.toString(),
                                          password: password.text.toString());
                                    }
                                  },
                                  color: Colors.indigo),
                            ],
                          );
                        },
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
