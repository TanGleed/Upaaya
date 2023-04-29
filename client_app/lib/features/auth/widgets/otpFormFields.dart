import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/auth/screens/resetpassword.dart';
import 'package:client_app/features/auth/services/authmodel.dart';
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class OTPFormField extends StatefulWidget {
  final bool isregisterScreen;
  final RegisterModal modal;
  const OTPFormField({
    required this.isregisterScreen,
    required this.modal,
    super.key,
  });

  @override
  State<OTPFormField> createState() => _OTPFormFieldState();
}

class _OTPFormFieldState extends State<OTPFormField> {
  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  String pin = '';
  bool isAsyncCallProcess = false;
  @override
  void initState() {
    super.initState();

    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    pin = pin + value;
    if (value.length == 1 && focusNode != pin1FocusNode) {
      focusNode!.requestFocus();
      setState(() {});
    } else if (value.length == 1) {
      focusNode!.unfocus();
      KeyboardUtil.hideKeyboard(context);
      setState(() {});
    }
  }

  void register() {
    isAsyncCallProcess = true;
    setState(() {});
    AuthServices.register(widget.modal).then((response) => {
          if (response)
            {
              isAsyncCallProcess = false,
              setState(() {}),
              FormHelper.showSimpleAlertDialog(
                context,
                'Successfull',
                "Successfully Regsitered!! You will be redirected to login",
                "OK",
                () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Auth.routeName,
                    (route) => false,
                  );
                },
              )
            }
          else
            {
              isAsyncCallProcess = false,
              setState(() {}),
              FormHelper.showSimpleAlertDialog(
                context,
                'Registration Failed',
                "Registration failed please Try againa later",
                "OK",
                () {
                  Navigator.pop(context);
                },
              )
            }
        });
  }

  void apicall(RegisterModal modal) {
    AuthServices.verifyotp(modal, pin).then((response) => {
          if (response == "Success")
            {
              isAsyncCallProcess = false,
              widget.isregisterScreen
                  ? register()
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ResetPasswordPage(email: modal.email))),
            }
          else if (response == "Invalid OTP")
            {
              isAsyncCallProcess = false,
              FormHelper.showSimpleAlertDialog(
                context,
                'Auth Failed',
                "Invalid OTP !!,Please Enter valid OTP",
                "OK",
                () {
                  Navigator.pop(context);
                },
              )
            }
          else if (response == "OTP Expired")
            {
              isAsyncCallProcess = false,
              FormHelper.showSimpleAlertDialog(
                context,
                'Auth Failed',
                " OTP Expired !!,Please Request For New one",
                "OK",
                () {
                  Navigator.pop(context);
                },
              )
            }
          else
            {
              isAsyncCallProcess = false,
              FormHelper.showSimpleAlertDialog(
                context,
                'Auth Failed',
                " Failed to validate Email",
                "OK",
                () {
                  Navigator.pop(context);
                },
              )
            },
          setState(
            () {},
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: GlobalVariable.screenHeight * 0.15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pinField(pin1FocusNode, pin2FocusNode),
            pinField(pin2FocusNode, pin3FocusNode),
            pinField(pin3FocusNode, pin4FocusNode),
            pinField(pin4FocusNode, pin1FocusNode),
          ],
        ),
        SizedBox(
          height: GlobalVariable.screenHeight * 0.15,
        ),
        isAsyncCallProcess
            ? SizedBox(
                width: double.infinity,
                height: GlobalVariable().getProportionateScreenHeight(56),
                child: ProgressHUD(
                  key: UniqueKey(),
                  inAsyncCall: isAsyncCallProcess,
                  child: Container(),
                ))
            : SizedBox(
                width: double.infinity,
                height: GlobalVariable().getProportionateScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: GlobalVariable.buttonsColors,
                  ),
                  onPressed: () {
                    setState(() {
                      isAsyncCallProcess = true;
                    });
                    apicall(widget.modal);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize:
                          GlobalVariable().getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  SizedBox pinField(
    FocusNode? pinFocusNode,
    FocusNode? nextFocusNode,
  ) {
    return SizedBox(
      width: GlobalVariable().getProportionateScreenWidth(60),
      child: TextFormField(
        focusNode: pinFocusNode,
        autofocus: false,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: GlobalVariable().getProportionateScreenWidth(15)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable().getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable().getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                GlobalVariable().getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
        ),
        onChanged: ((value) {
          nextField(value, nextFocusNode);
        }),
      ),
    );
  }
}
