import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/hompage.dart';
import 'package:client_app/features/homepage/screens/request_page.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard-screen';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int activeindex = 0;
  static const iconslist = <IconData>[
    Icons.home_rounded,
    Icons.history_rounded,
  ];
  final List<Widget> widgetList = const [
    HomePage(),
    RequestPage(),
    //upload page
  ];
  @override
  Widget build(BuildContext context) {
    GlobalVariable().init(context);
    return Scaffold(
      backgroundColor: GlobalVariable.backgroundcolor,
      floatingActionButton: FloatingActionButton(
          clipBehavior: Clip.hardEdge,
          focusColor: Colors.deepPurpleAccent,
          backgroundColor:
              activeindex == 2 ? GlobalVariable.buttonsColors : Colors.blueGrey,
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            activeindex = 2;
            setState(() {});
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.blueGrey,
        activeColor: GlobalVariable.buttonsColors,
        icons: iconslist,
        activeIndex: activeindex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          activeindex = index;
          setState(() {});
        },
        blurEffect: true,
        notchMargin: 15,
        height: GlobalVariable.screenHeight * 0.06,
        iconSize: 30,
        //other params
      ),
      body: widgetList[activeindex],
    );
  }
}
