import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/auth/screens/login.dart';
import 'package:client_app/features/auth/screens/otp.dart';
import 'package:client_app/features/homepage/screens/dashboard.dart';
import 'package:client_app/features/homepage/screens/hompage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/retry.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      final args = routeSettings.arguments as LoginPage;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginPage(
                showRegisterPage: args.showRegisterPage,
              ));
    case VerifyOTP.routeName:
      final arg = routeSettings.arguments as VerifyOTP;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => VerifyOTP(
                value: arg.value,
                isregisterscreen: arg.isregisterscreen,
              ));
    case Auth.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Auth(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case DashBoard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashBoard(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(),
      );
  }
}
