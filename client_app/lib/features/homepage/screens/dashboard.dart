import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/hompage.dart';
import 'package:client_app/features/homepage/screens/request_page.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard-screen';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final panelController = PanelController();
  late GoogleMapController _googleMapController;
  final CameraPosition _initialposition =
      const CameraPosition(target: LatLng(27.6667, 85.3500), zoom: 14);
  int activeindex = 0;
  Set<Marker> markers = {};
  GoogleMapController onMapCreated(GoogleMapController ctrl) {
    _googleMapController = ctrl;
    return _googleMapController;
  }

  // static const iconslist = <IconData>[
  //   Icons.home_rounded,
  //   Icons.history_rounded,
  // ];
  // final List<Widget> widgetList = const [
  //   HomePage(),
  //   RequestPage(),
  //   //upload page
  // ];
  @override
  Widget build(BuildContext context) {
    GlobalVariable().init(context);
    return Scaffold(
        key: _scaffoldState,
        drawer: NavigationDrawerWidget(),
        // appBar: AppBar(
        //   backgroundColor: Colors.deepPurpleAccent,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: const Text(
        //     GlobalVariable.appName,
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        //   actions: [
        //     IconButton(
        //       color: Colors.black,
        //       onPressed: () {
        //         //notification page
        //       },
        //       icon: SvgPicture.asset("assets/icons/notification.svg"),
        //     ),
        //   ],
        // ),
        backgroundColor: GlobalVariable.backgroundcolor,
        // floatingActionButton: FloatingActionButton(
        //     clipBehavior: Clip.hardEdge,
        //     focusColor: Colors.deepPurpleAccent,
        //     backgroundColor: activeindex == 2
        //         ? GlobalVariable.buttonsColors
        //         : Colors.blueGrey,
        //     child: const Icon(
        //       Icons.camera_alt_outlined,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       activeindex = 2;
        //       setState(() {});
        //     }),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   inactiveColor: Colors.blueGrey,
        //   activeColor: GlobalVariable.buttonsColors,
        //   icons: iconslist,
        //   activeIndex: activeindex,
        //   gapLocation: GapLocation.center,
        //   notchSmoothness: NotchSmoothness.verySmoothEdge,
        //   leftCornerRadius: 32,
        //   rightCornerRadius: 32,
        //   onTap: (index) {
        //     activeindex = index;
        //     setState(() {});
        //   },
        //   blurEffect: true,
        //   notchMargin: 15,
        //   height: GlobalVariable.screenHeight * 0.06,
        //   iconSize: 30,
        //   //other params
        // ),
        body: Stack(children: [
          SlidingUpPanel(
            panelBuilder: (sc) {
              return const SingleChildScrollView();
            },
            header: const JobCategories(),
            controller: panelController,
            minHeight: MediaQuery.of(context).size.height * 0.456,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            body: GoogleMap(
              initialCameraPosition: _initialposition,
              onMapCreated: onMapCreated,
              zoomControlsEnabled: false,
              markers: markers,
              mapType: MapType.normal,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          Positioned(
            top: GlobalVariable.screenHeight * 0.05,
            left: GlobalVariable.screenWidth * 0.05,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {
                  _scaffoldState.currentState?.openDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: GlobalVariable.screenHeight * 0.05,
            right: GlobalVariable.screenWidth * 0.05,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/notification.svg",
                ),
                onPressed: () {},
              ),
            ),
          ),
        ]));
  }
}
