import 'package:client_app/constants/globalVariable.dart';
import 'package:flutter/material.dart';

class FormFields {
  Container formFields(
      TextEditingController controller, bool password, String hinttext) {
    return Container(
      decoration: BoxDecoration(
          color: GlobalVariable.textFieldbackgroundcolor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(left: GlobalVariable.screenWidth * 0.04),
        child: TextField(
          enableSuggestions: false,
          controller: controller,
          obscureText: password,
          decoration: InputDecoration(
            hintText: hinttext,
            border: InputBorder.none,
            prefixIcon: password
                ? const Icon(Icons.key_rounded)
                : const Icon(Icons.email_rounded),
          ),
        ),
      ),
    );
  }
}
