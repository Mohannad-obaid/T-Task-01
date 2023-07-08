import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }


    _kLake2 = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng((await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)).latitude, (await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)).longitude),
        tilt: 59.440717697143555,
        zoom: 20.151926040649414);
    setState(() {});

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  late CameraPosition _kLake2;


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.52939433711108, 34.45657726997659),
    zoom: 12.4746,
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),

      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: _goToTheLake,
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    await _determinePosition();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake2));
  }
}