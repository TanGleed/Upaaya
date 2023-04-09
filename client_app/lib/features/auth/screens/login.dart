import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/auth/screens/forgotpass.dart';
import 'package:client_app/features/auth/services/auth_api_service.dart';
import 'package:client_app/features/homepage/screens/hompage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client_app/features/auth/widgets/authFormFields.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-screen';
  final VoidCallback showRegisterPage;
  const LoginPage({
    required this.showRegisterPage,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isAsyncProcess = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginIN() {
    bool validatedForm = formkey.currentState!.validate();
    if (validatedForm) {
      isAsyncProcess = true;
      setState(() {});
      AuthAPIService.login(emailController, passwordController)
          .then((response) => {
                if (response == "Success")
                  {
                    setState(() {
                      isAsyncProcess = false;
                    }),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ))
                  }
                else if (response == "Invalid Password")
                  {
                    FormHelper.showSimpleAlertDialog(
                        context,
                        "Authentication failed",
                        "Password didn't match!! \nPlease Enter a valid password",
                        "OK", () {
                      setState(() {
                        isAsyncProcess = false;
                      });
                      Navigator.pop(context);
                    })
                  }
                else if (response == "Email Not Registered")
                  {
                    FormHelper.showSimpleAlertDialog(
                        context,
                        "Authentication failed",
                        "Email Not Registered!!\n  Please Register Your Email",
                        "OK", () {
                      setState(() {
                        isAsyncProcess = false;
                      });
                      Navigator.pop(context);
                    })
                  }
                else
                  {
                    FormHelper.showSimpleAlertDialog(
                        context,
                        "Authentication failed",
                        "Login Failed!!\n Please try again",
                        "OK", () {
                      setState(() {
                        isAsyncProcess = false;
                      });
                      Navigator.pop(context);
                    })
                  }
              });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.backgroundcolor,
      body: SafeArea(
        child: ProgressHUD(
          inAsyncCall: isAsyncProcess,
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
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.screenWidth * 0.05),
                      child: Column(
                        children: [
                          FormFields().formFields(
                              emailController, false, true, "Email"),
                          const SizedBox(
                            height: 10,
                          ),
                          FormFields().formFields(
                              passwordController, true, false, "Password"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.screenWidth * 0.6),
                      child: GestureDetector(
                          onTap: (() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage(),
                              ))),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: GlobalVariable.screenWidth * 0.3),
                      child: GestureDetector(
                        onTap: () {
                          loginIN();
                        }, //APi Calls
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: GlobalVariable.buttonsColors,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              'Sign In',
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
                          'Not Registered?',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalVariable.buttonsColors,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
