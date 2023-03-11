import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/auth/widgets/authFormFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    required this.showLoginPage,
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    bool validatedForm = formkey.currentState!.validate();
    if (!validatedForm) {
      return;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.backgroundcolor,
      body: SafeArea(
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
                            horizontal: GlobalVariable.screenWidth * 0.05),
                        child: Column(
                          children: [
                            FormFields().formFields(
                                nameController, false, false, "Full Name"),
                            const SizedBox(
                              height: 10,
                            ),
                            FormFields().formFields(
                                emailController, false, true, "Email"),
                            const SizedBox(
                              height: 10,
                            ),
                            FormFields().formFields(
                                passwordController, true, false, "Password"),
                            const SizedBox(
                              height: 10,
                            ),
                            FormFields().formFields(confirmPasswordController,
                                true, false, "Confirm Password"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: GlobalVariable.screenWidth * 0.3),
                        child: GestureDetector(
                          onTap: () {
                            register();
                          }, //APi Calls
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: GlobalVariable.buttonsColors,
                                borderRadius: BorderRadius.circular(20)),
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
    );
  }
}
