import 'package:client_app/api_service.dart/apiService.dart';
import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/auth/widgets/authFormFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ResetPasswordPage extends StatefulWidget {
  final TextEditingController email;
  const ResetPasswordPage({
    required this.email,
    super.key,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool isAsyncprocess = false;
  final formkey = GlobalKey<FormState>();

  TextEditingController newpassword = TextEditingController();
  TextEditingController newConfirmpassword = TextEditingController();

  void resetpass() {
    bool validatedForm = formkey.currentState!.validate();
    if (validatedForm) {
      isAsyncprocess = true;
      setState(() {});
      APIService.resetpassword(widget.email, newConfirmpassword)
          .then((value) => {
                if (value)
                  {
                    isAsyncprocess = false,
                    setState(() {}),
                    FormHelper.showSimpleAlertDialog(
                      context,
                      'Successfull',
                      "Successfully Updated!! You will be redirected to login",
                      "OK",
                      () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const Auth()),
                            (route) => false);
                      },
                    )
                  }
                else
                  {
                    isAsyncprocess = false,
                    setState(() {}),
                    FormHelper.showSimpleAlertDialog(
                      context,
                      'Unsuccessfull',
                      "Password Reset Failed ,Please try again later",
                      "OK",
                      () {
                        Navigator.pop(context);
                      },
                    )
                  }
              });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
          key: UniqueKey(),
          inAsyncCall: isAsyncprocess,
          opacity: 0.5,
          child: Form(
            key: formkey,
            child: Body(),
          ),
        ),
      ),
    );
  }

  Widget Body() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable().getProportionateScreenWidth(25),
        ),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(
            " Create Password",
            style: TextStyle(
                fontSize: GlobalVariable().getProportionateScreenWidth(30),
                color: Colors.black,
                fontWeight: FontWeight.bold,
                height: 1.5),
          ),
          const Text(
            "Enter new password to return to you account \nand return to login",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: GlobalVariable.screenHeight * 0.07,
          ),
          FormFields()
              .formFields(newpassword, true, false, "Enter new Password"),
          SizedBox(
            height: GlobalVariable.screenHeight * 0.01,
          ),
          FormFields().formFields(
              newConfirmpassword, true, false, "Confirm new Password"),
          SizedBox(
            height: GlobalVariable.screenHeight * 0.01,
          ),
          Center(
            child: FormHelper.submitButton("Reset Password", () {
              resetpass();
            },
                btnColor: Colors.deepPurple,
                borderColor: Colors.white,
                borderRadius: 20,
                txtColor: Colors.white),
          ),
          SizedBox(
            height: GlobalVariable.screenHeight * 0.01,
          ),
        ]),
      )),
    );
  }
}
