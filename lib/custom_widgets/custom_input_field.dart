import 'package:flutter/material.dart';

class CustomInputField{
  bool obscureText = false;
  Widget customInputField({
    required IconData icon,
    required String text,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    bool obscureText = false,
    String? Function(String?)? validate,
    VoidCallback? postIconClicked,
    Color themeColor = Colors.black,
    IconData? postIcon,
    IconData? passwordShowIcon,
    String labelText = "",
    bool haveLabel = false,
    required TextEditingController controller
  })
  {
    this.obscureText = obscureText;
    return TextFormField(
      style: TextStyle(color: themeColor),
      readOnly: readOnly,
      obscureText: this.obscureText,
      controller: controller,
      validator: validate,
      maxLines: maxLines,
      keyboardType:inputType,
      decoration: InputDecoration(
        label:haveLabel?Text(labelText):null,
        prefixIcon: Icon(icon,color: themeColor,),
        suffixIcon: IconButton(icon:Icon(this.obscureText?passwordShowIcon:postIcon,color:themeColor),color:themeColor,onPressed:postIconClicked,),
        hintText: text,
        hintStyle: TextStyle(color: themeColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeColor),
            borderRadius: BorderRadius.circular(10.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: themeColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10.0)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}