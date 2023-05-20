import 'package:flutter/material.dart';

class CustomInputField{
  Widget customInputField({
    required IconData icon,
    required String text,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    bool obscureText = false,
    String? Function(String?)? validate,
    Color themeColor = Colors.black,
    required TextEditingController controller
  })
  {
    return TextFormField(
      style: TextStyle(color: themeColor),
      readOnly: readOnly,
      obscureText: obscureText,
      controller: controller,
      validator: validate,
      maxLines: maxLines,
      keyboardType:inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: themeColor,),
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