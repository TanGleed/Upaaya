import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            children: [JobCategories()],
          )),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
