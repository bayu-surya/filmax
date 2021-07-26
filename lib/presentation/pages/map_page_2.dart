import 'dart:async';

import 'package:filmax/presentation/pages/map_page_3.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Map2Page extends StatefulWidget {
  static const routeName = '/map2';

  const Map2Page();

  @override
  _Map2PageState createState() => _Map2PageState();
}

class _Map2PageState extends State<Map2Page> {
  late GoogleMapController mapController;
  LatLng latlong = const LatLng(-6.200000, 106.816666);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
    getCurrentLocation();
  }

  void _onCameraMove(CameraPosition position) {
    latlong = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map 2 Google',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Map3Page.routeName);
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
            trafficEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _cameraPosition,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.map, size: 30.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.add_location, size: 30.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //ganti tampilan map
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  //tambah marker
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(latlong.toString()),
        position: latlong,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        // BitmapDescriptor.fromAsset(‘assets/asset_name.png),
      ));
    });
  }

  //get current location
  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // ignore: unrelated_type_equality_checks
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      // ignore: unrelated_type_equality_checks
      if (permission != PermissionStatus.granted) getLocation();
      return;
    }
    getLocation();
  }

  List<Address> results = [];
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);

    setState(() {
      latlong = new LatLng(position.latitude, position.longitude);
      _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      _markers.add(Marker(
          markerId: MarkerId("a"),
          draggable: true,
          position: latlong,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onDragEnd: (_currentlatLng) {
            latlong = _currentlatLng;
          }));
    });

    getCurrentAddress();
  }

  getCurrentAddress() async {
    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    results = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    var address;
    address = first.featureName;
    address = " $address, ${first.subLocality}";
    address = " $address, ${first.subLocality}";
    address = " $address, ${first.locality}";
    address = " $address, ${first.countryName}";
    address = " $address, ${first.postalCode}";

    // locationController.text = address;

    print("atmoko 1" + address);
    print("atmoko 2" +
        latlong.latitude.toString() +
        " " +
        latlong.longitude.toString());
  }
}
