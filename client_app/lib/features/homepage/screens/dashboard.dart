import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/jobpost_page.dart';
import 'package:client_app/features/homepage/services/Mapservices.dart';
import 'package:client_app/features/homepage/services/job_post_notifier.dart';

import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:client_app/sharedpreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  String email = '';
  String location = '';
  final panelController = PanelController();
  late GoogleMapController _googleMapController;
  CameraPosition _initialposition = CameraPosition(
      target: LatLng(27.61906510050622, 85.53869817405939), zoom: 16);
  int activeindex = 0;
  LatLng? markerPosition;
  Set<Marker> markers = {};
  GoogleMapController onMapCreated(GoogleMapController ctrl) {
    _googleMapController = ctrl;

    return _googleMapController;
  }

  void onMarkerDragEnd(LatLng newPosition) {
    setState(() {
      markerPosition = newPosition;
    });
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    await placemarkFromCoordinates(lat, lng).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        location = '${place.street}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    LoginSharedPreferences().getemail().then((userEmail) {
      setState(() {
        email = userEmail;
      });
    });

    MapServices().determinePosition().then(
      (position) {
        setState(() {
          _initialposition = CameraPosition(target: position, zoom: 14);
          _getAddressFromLatLng(position.latitude, position.longitude);
          markerPosition = position;
          markers.add(
            Marker(
              markerId: MarkerId('movable_marker'),
              position: markerPosition!,
              draggable: true,
              onDragEnd: onMarkerDragEnd,
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    var jobprovider = Provider.of<JobPostNotifier>(context, listen: true);
    jobprovider.job.location = location;
    userprovider.getUserDetails(email);
    GlobalVariable().init(context);
    return Scaffold(
        key: _scaffoldState,
        drawer: const NavigationDrawerWidget(),
        backgroundColor: GlobalVariable.backgroundcolor,
        body: Stack(children: [
          SlidingUpPanel(
            renderPanelSheet: false,
            backdropEnabled: false,
            backdropTapClosesPanel: false,
            panelSnapping: false,
            parallaxEnabled: false,
            panelBuilder: (sc) {
              return JobPostPage();
            },
            controller: panelController,
            minHeight: MediaQuery.of(context).size.height * 0.456,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            body: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _initialposition,
              onMapCreated: onMapCreated,
              zoomControlsEnabled: false,
              markers: markers,
              mapType: MapType.normal,
              onTap: (position) {
                setState(() {
                  _initialposition = CameraPosition(target: position, zoom: 18);
                  _googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(_initialposition));
                  jobprovider.job.latitude = position.latitude;
                  jobprovider.job.longitude = position.longitude;
                  _getAddressFromLatLng(position.latitude, position.longitude);
                  jobprovider.job.location = location;
                  markers.clear();
                  markerPosition = position;
                  markers.add(
                    Marker(
                      markerId: const MarkerId('movable_marker'),
                      position: markerPosition!,
                      draggable: true,
                      onDragEnd: onMarkerDragEnd,
                    ),
                  );
                });
              },
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
