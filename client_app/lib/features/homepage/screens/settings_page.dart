import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../auth/screens/otp.dart';
import '../../auth/services/authmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void changepassword(BuildContext context, RegisterModal val) async {
    final email = Provider.of<UserProvider>(context, listen: false).user.email;
    val.email.text = email;
    AuthServices.sendotp(val).then((response) {
      if (response) {
        Navigator.pushNamed(context, VerifyOTP.routeName,
            arguments: VerifyOTP(
              isregisterscreen: false,
              value: val,
            ));
      } else {
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
            body: SafeArea(
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
                      SettingsTile.switchTile(
                        onToggle: (value) {},
                        initialValue: true,
                        leading: Icon(Icons.format_paint),
                        title: Text('Enable custom theme'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
