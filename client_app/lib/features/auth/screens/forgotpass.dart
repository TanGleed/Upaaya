import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/auth/screens/otp.dart';
import 'package:client_app/features/auth/services/authmodel.dart';
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:client_app/features/auth/widgets/authFormFields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/forgotpassword-screen';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isAsyncprocess = false;
  final formkey = GlobalKey<FormState>();

  void validate(RegisterModal modal) {
    bool validatedForm = formkey.currentState!.validate();
    if (validatedForm) {
      isAsyncprocess = true;
      setState(() {});
      AuthServices.uniqueEmail(modal).then((value) => {
            if (!value)
              {
                sendotp(modal),
              }
            else
              {
                FormHelper.showSimpleAlertDialog(
                    context, "Auth Error", "Email Not registered", "OK", () {
                  setState(() {
                    isAsyncprocess = false;
                    Navigator.pop(context);
                  });
                })
              }
          });
    } else {
      return;
    }
  }

  void sendotp(RegisterModal modal) {
    AuthServices.sendotp(modal).then((response) {
      if (response) {
        isAsyncprocess = false;
        setState(() {});
        Navigator.pushNamed(context, VerifyOTP.routeName,
            arguments: VerifyOTP(
              isregisterscreen: false,
              value: modal,
            ));
      } else {
        FormHelper.showSimpleAlertDialog(
            context, "OTP Error !!", "OTP Couldn't be sent", "ok", () {
          setState(() {
            isAsyncprocess = false;
            Navigator.pop(context);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterModal(),
      child: Consumer<RegisterModal>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: GlobalVariable.backgroundcolor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: GlobalVariable.backgroundcolor,
            ),
            body: ProgressHUD(
              key: UniqueKey(),
              inAsyncCall: isAsyncprocess,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: body(value),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget body(RegisterModal value) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable().getProportionateScreenWidth(20),
        ),
        child: emailForm(value),
      ),
    );
  }

  Widget emailForm(RegisterModal value) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: GlobalVariable().getProportionateScreenWidth(27),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        const Text(
          "Please Enter Your Regsitered Email and We will send \nyou an OTP",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: GlobalVariable.screenHeight * 0.05,
        ),
        FormFields(
            icon: Icons.email,
            controller: value.email,
            password: false,
            email: true,
            hinttext: "Enter Your Email"),
        SizedBox(
          height: GlobalVariable.screenHeight * 0.01,
        ),
        Center(
          child: FormHelper.submitButton("Get OTP", () {
            validate(value);
          },
              btnColor: Colors.deepPurple,
              borderColor: Colors.white,
              borderRadius: 20,
              txtColor: Colors.white),
        ),
        SizedBox(
          height: GlobalVariable.screenHeight * 0.01,
        ),
      ],
    );
  }
}
