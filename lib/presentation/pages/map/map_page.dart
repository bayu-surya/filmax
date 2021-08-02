import 'package:filmax/presentation/pages/map/map_page_2.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  static const routeName = '/map';

  const MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng latlong = const LatLng(-6.200000, 106.816666);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  Location _location = Location();

  void _onCameraMove(CameraPosition position) {
    latlong = position.target;
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map 1 Location',
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
                  Navigator.pushNamed(context, Map2Page.routeName);
                },
                child: Icon(
                  Icons.map,
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
            // initialCameraPosition: _cameraPosition,
            initialCameraPosition: CameraPosition(
              target: latlong,
              zoom: 11.0,
            ),
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
}
