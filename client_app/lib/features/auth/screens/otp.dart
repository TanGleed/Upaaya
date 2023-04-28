import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/auth/services/authmodel.dart';
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:client_app/features/auth/widgets/otpFormFields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class VerifyOTP extends StatefulWidget {
  static const String routeName = '/OTP-screen';
  final bool isregisterscreen;
  final RegisterModal value;
  const VerifyOTP({
    required this.isregisterscreen,
    required this.value,
    super.key,
  });

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  static bool showResendOTP = false;
  static bool isAsyncprocess = false;
  void sendotp(RegisterModal modal) {
    isAsyncprocess = true;
    setState(() {});
    AuthServices.sendotp(modal).then((response) {
      if (response) {
        showResendOTP = false;
        isAsyncprocess = false;
        setState(() {});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => VerifyOTP(
                    value: modal,
                    isregisterscreen: widget.isregisterscreen,
                  )),
        );
      } else {
        FormHelper.showSimpleAlertDialog(
            context, "OTP Error !!", "OTP Couldn't be sent", "ok", () {
          isAsyncprocess = false;
          showResendOTP = true;
          setState(() {});
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.backgroundcolor,
      appBar: AppBar(
        backgroundColor: GlobalVariable.backgroundcolor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
          hoverColor: GlobalVariable.buttonsColors,
          color: GlobalVariable.buttonsColors,
        ),
      ),
      body: body(),
    );
  }

  SizedBox body() {
    return SizedBox(
      width: double.infinity,
      child: ProgressHUD(
        key: UniqueKey(),
        inAsyncCall: isAsyncprocess,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable().getProportionateScreenWidth(20)),
            child: SafeArea(
              child: otpForm(),
            ),
          ),
        ),
      ),
    );
  }

  Column otpForm() {
    return Column(children: [
      SizedBox(
        height: GlobalVariable.screenHeight * 0.05,
      ),
      Text(
        "OTP Verification",
        style: TextStyle(
          fontSize: GlobalVariable().getProportionateScreenWidth(28),
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.5,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          children: <TextSpan>[
            const TextSpan(text: "OTP sent to "),
            TextSpan(
              text: widget.value.email.text,
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: " check inbox/spam folder",
            ),
          ],
        ),
      ),
      SizedBox(
        height: GlobalVariable.screenHeight * 0.05,
      ),
      OTPFormField(
        isregisterScreen: widget.isregisterscreen,
        modal: widget.value,
      ),
      SizedBox(
        height: GlobalVariable.screenHeight * 0.1,
      ),
      showResendOTP
          ? RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "Resend OTP?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          sendotp(widget.value);
                        }),
                ],
              ),
            )
          : showtime()
    ]);
  }

  Row showtime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Resend OTP in ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        TweenAnimationBuilder(
            tween: Tween(
              begin: 60.0,
              end: 0.0,
            ),
            onEnd: () {
              setState(() {
                showResendOTP = true;
                KeyboardUtil.hideKeyboard(context);
              });
            },
            duration: const Duration(seconds: 60),
            builder: (_, dynamic value, child) => Text(
                  "00:${value.toInt()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: GlobalVariable.buttonsColors,
                  ),
                ))
      ],
    );
  }
}
