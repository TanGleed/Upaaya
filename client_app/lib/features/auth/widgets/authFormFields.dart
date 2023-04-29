import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class FormFields {
  Container formFields(
    TextEditingController controller,
    bool password,
    bool email,
    String hinttext,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: GlobalVariable.textFieldbackgroundcolor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(left: GlobalVariable.screenWidth * 0.04),
        child: TextFormField(
            enableSuggestions: false,
            controller: controller,
            obscureText: password,
            decoration: InputDecoration(
              hintText: hinttext,
              border: InputBorder.none,
              prefixIcon: password
                  ? const Icon(Icons.key_rounded)
                  : email
                      ? const Icon(Icons.email_rounded)
                      : const Icon(Icons.person_2_rounded),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (password) {
                if (value!.isEmpty) {
                  return '*Required';
                } else if (value.length < 6) {
                  return "Minimum 6 characters Required";
                } else {
                  return null;
                }
              } else if (email) {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);
                if (value.isEmpty) {
                  return '*Required';
                } else if (!emailValid) {
                  return "E-mail Invalid";
                } else {
                  return null;
                }
              } else {
                if (value!.isEmpty) {
                  return '*Required';
                }
              }
            }),
      ),
    );
  }
}
