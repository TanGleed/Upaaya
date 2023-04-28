import 'dart:convert';
import 'dart:ffi';

import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/homepage/screens/dashboard.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:client_app/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as pro;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.

final exampleProvider = pro.Provider((_) => 'Upaaya Client');
Widget _defaultHome = const Auth();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((value) {
    print("token: $value");
  });
  SharedPreferences pref = await SharedPreferences.getInstance();
  String result = pref.getString("email") ?? "";
  if (result != null) {
    _defaultHome = const DashBoard();
  }
// While the application is runnig in background
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      Navigator.pushNamed(
        navigatorKey.currentState!.context,
        '/push-page',
        arguments: {"message": json.encode(message.data)},
      );
    },
  );

// While the application is closed
  FirebaseMessaging.instance.getInitialMessage().then(
    (RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          navigatorKey.currentState!.context,
          '/push-page',
          arguments: {"message": json.encode(message.data)},
        );
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.

    pro.ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

//Handling background process
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler: $message");
}

// Extend HookConsumerWidget instead of HookWidget, which is exposed by Riverpod
class MyApp extends pro.HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, pro.WidgetRef ref) {
    // We can use hooks inside HookConsumerWidget
    final counter = useState(0);

    // final String value = ref.watch(exampleProvider);

    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      navigatorKey: navigatorKey,
      home: _defaultHome,
    );
  }
}
