import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/auth/screens/forgotpass.dart';
import 'package:client_app/features/auth/screens/login.dart';
import 'package:client_app/features/auth/screens/otp.dart';
import 'package:client_app/features/auth/screens/resetpassword.dart';
import 'package:client_app/features/homepage/screens/dashboard.dart';
import 'package:client_app/features/homepage/screens/hompage.dart';
import 'package:client_app/features/homepage/screens/settings_page.dart';
import 'package:flutter/material.dart';

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
    case ForgotPasswordPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ForgotPasswordPage());
    case DashBoard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashBoard(),
      );
    case SettingsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingsPage(),
      );
    case ResetPasswordPage.routeName:
      final args = routeSettings.arguments as ResetPasswordPage;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ResetPasswordPage(
                email: args.email,
                isChangepassowrd: args.isChangepassowrd,
              ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(),
      );
  }
}
