import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      Map? pushArguments = arguments as Map;

      setState(() {
        message = pushArguments[message];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: GlobalVariable.backgroundcolor,
          drawer: NavigationDrawerWidget(),
          floatingActionButton: FloatingActionButton(
              clipBehavior: Clip.hardEdge,
              focusColor: Colors.deepPurpleAccent,
              backgroundColor:
                  activeindex == 3 ? GlobalVariable.buttonsColors : null,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                activeindex = 3;
                setState(() {});
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            inactiveColor: Colors.blueGrey,
            activeColor: GlobalVariable.buttonsColors,
            icons: iconslist,
            activeIndex: activeindex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => setState(() => activeindex = index),
            blurEffect: true,
            notchMargin: 15,
            height: GlobalVariable.screenHeight * 0.06,
            iconSize: 30,
            //other params
          ),
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
          body: ListView(children: [JobCategories()])),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
