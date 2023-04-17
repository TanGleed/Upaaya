import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:worker_app/api_service.dart/apiService.dart';
import 'package:worker_app/features/auth/screens/otp.dart';
import 'package:worker_app/features/auth/services/authmodel.dart';

import '../../../constants/globalVariable.dart';
import '../widgets/authFormFields.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register-screen';
  final VoidCallback showLoginPage;
  const RegisterPage({
    required this.showLoginPage,
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAsyncallonprogress = false;
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  void sendotp(RegisterModal modal) {
    APIService.sendotp(modal).then((response) {
      if (response) {
        isAsyncallonprogress = false;
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VerifyOTP(
                      value: modal,
                      isregisterscreen: true,
                    )));
      } else {
        FormHelper.showSimpleAlertDialog(
            context, "OTP Error !!", "OTP Couldn't be sent", "ok", () {
          setState(() {
            isAsyncallonprogress = false;
            Navigator.pop(context);
          });
        });
      }
    });
  }

  void register(RegisterModal modal) {
    bool validatedForm = formkey.currentState!.validate();
    if (validatedForm) {
      setState(() {
        isAsyncallonprogress = true;
      });
      APIService.uniqueEmail(modal).then((response) {
        if (response) {
          sendotp(modal);
        } else {
          FormHelper.showSimpleAlertDialog(context, "Already Registered",
              "Email Already registered", "Login", () {
            setState(() {
              isAsyncallonprogress = false;
              Navigator.pop(context);
            });
          });
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterModal(),
      child: Consumer<RegisterModal>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: GlobalVariable.backgroundcolor,
            body: SafeArea(
              child: ProgressHUD(
                inAsyncCall: isAsyncallonprogress,
                key: UniqueKey(),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Logo.png",
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Upaaya',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              letterSpacing: 6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Regsiter Here",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 50),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.screenWidth * 0.05),
                                child: Column(
                                  children: [
                                    FormFields().formFields(
                                        value.name, false, false, "Full Name"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FormFields().formFields(
                                        value.email, false, true, "Email"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FormFields().formFields(value.password,
                                        true, false, "Password"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FormFields().formFields(
                                        value.confirmpassword,
                                        true,
                                        false,
                                        "Confirm Password"),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.screenWidth * 0.3),
                                child: GestureDetector(
                                  onTap: () {
                                    register(value);
                                  }, //APi Calls
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: GlobalVariable.buttonsColors,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Center(
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already Registered?',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.showLoginPage,
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: GlobalVariable.buttonsColors,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              // const Text(
                              //   "Register With",
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
