import 'package:client_app/features/auth/screens/login.dart';
import 'package:client_app/features/auth/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginPage(
                showRegisterPage: () {},
              ));
    // case VerifyOTP.routeName:
    //   final  arg = routeSettings.arguments;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => VerifyOTP(
    //             value:arg.hashCode,
    //           ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(),
      );
  }
}
