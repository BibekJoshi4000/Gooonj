import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gooonj_app/theme.dart';

// late double latitudedv;
// late double longitudedv;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  // late BitmapDescriptor myIcon;


  // void initState() {
  //    getMarker();
  //   super.initState();
  // }
  // void getMarker()async{
  //   myIcon=await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5), 'assets/png/location_on.png');
  //
  // }
  // StreamSubscription<Position>? positionst;
  // Map<PolylineId, Polyline> polylines = {};
  // PolylinePoints polylinePoints = PolylinePoints();
  //
  // getDirection(LatLng dst) async {
  //   List<LatLng> polylineCoordinates = [];
  //   List<dynamic> points = [];
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     '',
  //     PointLatLng(latitudedv, longitudedv),
  //     PointLatLng(dst.latitude, dst.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       points.add({'lat': point.latitude, 'lng': point.longitude});
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   addPolyLine(polylineCoordinates);
  // }
  //
  // addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId('poly');
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: mainRed, points: polylineCoordinates, width: 2);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

  // Future<StreamSubscription<Position>> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   // if (!serviceEnabled) {
  //   //   return Future.error('Location services are disabled.');
  //   // }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   final LocationSettings locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  //   StreamSubscription<Position> positionStream =
  //       Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((Position? position) {
  //     latitudedv = double.parse(position!.latitude.toString());
  //     longitudedv = double.parse(position!.longitude.toString());
  //     print(latitudedv);
  //     print(longitudedv);
  //     print(position == null
  //         ? 'Unknown'
  //         : '${position.latitude.toString()}, ${position.longitude.toString()}');
  //   });
  //   return await positionStream;
  // }
  //
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     positionst != determinePosition();
  //   });
  // }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.8651735, 77.8963589),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Marker iitRoorkeeMarker = Marker(
      markerId: MarkerId('IIT Roorkee'),
      onTap: () {
        print('dfdfdfhdhdfh');
        buildShowModalBottomSheet(context, size);
      },
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(29.8651735, 77.8963589),
      infoWindow: InfoWindow(title: 'IIT Roorkee'),
    );
    // final Marker devicelocation = Marker(
    //   markerId: MarkerId('devicelocation'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   position: LatLng(latitudedv, longitudedv),
    //   infoWindow: InfoWindow(title: 'Your Location'),
    // );
final Marker devicelocation2 = Marker(
      markerId: MarkerId('devicelocation'),
      icon: BitmapDescriptor.defaultMarker,
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(29.8659, 77.8963),
      infoWindow: InfoWindow(title: 'Your Location'),
    );
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          compassEnabled: true,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          markers: {iitRoorkeeMarker,devicelocation2},
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: size.height * .3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'IIT Roorkee Gooonj Hotspot',
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "Outfit-Bold",
                      fontSize: size.width * .07,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'IIT Roorkee, Roorkee, Uttrakhand',
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "Outfit-Regular",
                      fontSize: size.width * .04,
                    ),
                  ),
                  Text(
                    'status: Working',
                    style: TextStyle(
                        fontFamily: "Outfit-Bold",
                        fontSize: size.width * .04,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .1,
              ),
              InkWell(
                // onTap: (){getDirection(LatLng(29.8651735, 77.8963589));},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: mainRed, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Direction',
                        style: TextStyle(
                            fontFamily: "Outfit-Bold",
                            fontSize: size.width * .05,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: size.width * .015,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
