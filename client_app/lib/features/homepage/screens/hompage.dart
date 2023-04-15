import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      Map? pushArguments = arguments as Map;

      setState(() {
        message = pushArguments["message"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: GlobalVariable.backgroundcolor,
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 0,
            title: Text(
              GlobalVariable.appName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                color: Colors.black,
                onPressed: () {
                  //notification page
                },
                icon: SvgPicture.asset("assets/icons/notification.svg"),
              ),
            ],
          ),
          body: ListView(
            children: [Text("Push Message: $message"), JobCategories()],
          )),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
