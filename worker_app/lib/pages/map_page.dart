import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:worker_app/constants/globalVariable.dart';
import 'package:worker_app/services/Mapservices.dart';

class MapPage extends StatefulWidget {
  final double desLat;
  final double desLng;
  final double sourcelat;
  final double sourcelng;
  const MapPage({
    super.key,
    required this.desLat,
    required this.desLng,
    required this.sourcelat,
    required this.sourcelng,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];

  // LocationData? currentLocation;

  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  // void getCurrentLocation() async {
  //   Location location = Location();

  //   location.getLocation().then((location) {
  //     currentLocation = location;
  //   });
  //   GoogleMapController googleMapController = await _controller.future;

  //   location.onLocationChanged.listen(
  //     (newLoc) {
  //       currentLocation = newLoc;

  //       googleMapController.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             zoom: 13.2,
  //             target: LatLng(
  //               newLoc.latitude!,
  //               newLoc.longitude!,
  //             ),
  //           ),
  //         ),
  //       );
  //       setState(() {});
  //     },
  //   );
  // }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ApiURL.google_api_key,
      PointLatLng(widget.sourcelat, widget.sourcelng),
      PointLatLng(widget.desLat, widget.desLng),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/images/user.png")
  //       .then((icon) {
  //     currentLocationIcon = icon;
  //   });
  // }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Map",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.5,
            ),
          ),
        ),
        body:
            // currentLocation == null
            //     ? const Center(
            //         child: Text("Loading"),
            //       )
            //     :
            GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.sourcelat, widget.sourcelng),
            // LatLng(currentLocation!.latitude!,
            //     currentLocation!.longitude!),
            zoom: 16,
          ),
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.purple,
              width: 6,
            ),
          },
          markers: {
            // Marker(
            //   markerId: MarkerId("currentLocation"),
            //   icon: currentLocationIcon,
            //   position: LatLng(
            //     currentLocation!.latitude!,
            //     currentLocation!.longitude!,
            //   ),
            // ),
            Marker(
              markerId: MarkerId("source"),
              position: LatLng(widget.sourcelat, widget.sourcelng),
            ),
            Marker(
              markerId: MarkerId("destination"),
              position: LatLng(widget.desLat, widget.desLng),
            ),
          },
          // onMapCreated: (mapController) {
          //   _controller.complete(mapController);
          // },
        ));
  }
}
