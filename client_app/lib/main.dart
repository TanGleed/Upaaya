import 'dart:convert';

import 'package:client_app/features/auth/screens/auth.dart';
import 'package:client_app/features/homepage/screens/dashboard.dart';
import 'package:client_app/features/homepage/services/homepageServices.dart';
import 'package:client_app/features/homepage/services/job_post_notifier.dart';
import 'package:client_app/features/homepage/services/userServices.dart';

import 'package:client_app/providers/UserProvider.dart';
import 'package:client_app/router.dart';
import 'package:client_app/sharedpreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart' as pro;
import 'package:provider/provider.dart';

Widget _defaultHome = const Auth();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late final bool isinitalized;
bool mode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //for map

  FirebaseMessaging.instance.getToken().then((value) {});
  String result = await LoginSharedPreferences().getloginToken();

  if (result != "Invalid Token") {
    _defaultHome = DashBoard();
  }

// While the application is runnig in background
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
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
          ChangeNotifierProvider(create: (_) => JobPostNotifier()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

//Handling background process
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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

  //initialze user
}
