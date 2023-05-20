import 'package:flutter/material.dart';

class CustomInputField{
  Widget customInputField({
    required IconData icon,
    required String text,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    required TextEditingController controller
  })
  {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      keyboardType:inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: text,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}