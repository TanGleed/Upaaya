import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/jobpost_page.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../providers/UserProvider.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard-screen';
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.getUserDetails('sudeepbhattarai1792@gmail.com');
    GlobalVariable().init(context);
    return Scaffold(
        key: _scaffoldState,
        drawer: const NavigationDrawerWidget(),
        backgroundColor: GlobalVariable.backgroundcolor,
        body: Stack(children: [
          SlidingUpPanel(
            panelBuilder: (sc) {
              return JobPostPage();
            },
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
