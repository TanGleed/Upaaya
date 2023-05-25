import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final bool password;
  final bool email;
  final String hinttext;
  FormFields({
    required this.icon,
    required this.hinttext,
    required this.controller,
    required this.password,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              suffixIcon: password
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        // Toggle password visibility
                        controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length));
                        if (password) {
                          controller.selection =
                              const TextSelection.collapsed(offset: 0);
                        }
                        password != password;
                      },
                    )
                  : null,
              prefixIcon: Icon(
                icon,
              )),
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
