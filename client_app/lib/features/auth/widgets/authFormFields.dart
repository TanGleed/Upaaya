import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class FormFields {
  Widget formFields(
    TextEditingController controller,
    bool password,
    bool email,
    String hinttext,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: GlobalVariable.screenWidth * 0.01),
      child: TextFormField(
          enableSuggestions: false,
          controller: controller,
          obscureText: password,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            hintText: hinttext,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black26,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.deepPurpleAccent,
              ),
            ),
            prefixIcon: password
                ? const Icon(Icons.key_rounded)
                : email
                    ? const Icon(Icons.email_rounded)
                    : const Icon(Icons.person_2_rounded),
          ),
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
    );
  }
}
