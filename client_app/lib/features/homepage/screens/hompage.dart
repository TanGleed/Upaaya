import 'package:client_app/constants/global_variable.dart';

import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:client_app/features/homepage/widgets/upload_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "";
  int activeindex = 3;
  static const iconslist = <IconData>[
    Icons.home_rounded,
    Icons.settings,
  ];
  final List<Widget> widgetList = const [
    HomePage(),
  ];
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
    return Scaffold(
      backgroundColor: GlobalVariable.backgroundcolor,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: const Text(
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
      body: ListView(children: const [
        JobCategories(),
      ]),
    );
  }
}
