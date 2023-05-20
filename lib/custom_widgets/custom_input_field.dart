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
    required TextEditingController controller
  })
  {
    return TextFormField(
      readOnly: readOnly,
      obscureText: obscureText,
      controller: controller,
      validator: validate,
      maxLines: maxLines,
      keyboardType:inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: text,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10.0)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}