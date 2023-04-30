// ignore_for_file: use_build_context_synchronously

import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../auth/screens/otp.dart';
import '../../auth/services/authmodel.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings-screen';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isasynccall = false;
  void changepassword(BuildContext context, RegisterModal val) async {
    final email = Provider.of<UserProvider>(context, listen: false).user.email;
    val.email.text = email;
    isasynccall = true;
    setState(() {});
    AuthServices.sendotp(val).then((response) {
      if (response) {
        isasynccall = false;
        setState(() {});
        Navigator.pushNamed(context, VerifyOTP.routeName,
            arguments: VerifyOTP(
              isregisterscreen: false,
              value: val,
            ));
      } else {
        isasynccall = false;
        setState(() {});
        FormHelper.showSimpleAlertDialog(
            context, "OTP Error !!", "OTP Couldn't be sent", "ok", () {
          Navigator.pop(context);
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
              title: const Text("Settings"),
              centerTitle: true,
              backgroundColor: Colors.deepPurpleAccent,
            ),
            body: ProgressHUD(
              key: UniqueKey(),
              inAsyncCall: isasynccall,
              child: SafeArea(
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: const Text('Account'),
                      tiles: <SettingsTile>[
                        SettingsTile.navigation(
                          leading: const Icon(Icons.lock),
                          title: const Text('Change Password'),
                          onPressed: (val) {
                            changepassword(context, value);
                          },
                        ),
                        SettingsTile.navigation(
                          title: const Text("Logout"),
                          leading: const Icon(Icons.logout_outlined),
                          onPressed: (context) async {
                            await AuthServices.logout(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, Auth.routeName, (route) => false);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
