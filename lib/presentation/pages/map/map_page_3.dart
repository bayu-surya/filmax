import 'package:filmax/presentation/pages/map/map_page_2.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map3Page extends StatefulWidget {
  static const routeName = '/map3';

  const Map3Page();

  @override
  _Map3PageState createState() => _Map3PageState();
}

class _Map3PageState extends State<Map3Page> {
  late GoogleMapController mapController;
  LatLng latlong = const LatLng(-6.200000, 106.816666);
  MapType _currentMapType = MapType.normal;

  Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionStatus;
  // late LocationData _locationData;

  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final Set<Circle> _circles = {};
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _circleIdCounter = 1;
  int _markerIdCounter = 1;
  double radius = 50;

  bool _isPolygon = true;
  bool _isMarker = false;
  bool _isCircle = false;

  void _checkLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    // _locationData = await _location.getLocation();
  }

  void _setMarker(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _setCircle(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    setState(() {
      _circles.add(
        Circle(
            circleId: CircleId(circleIdVal),
            center: point,
            radius: radius,
            fillColor: Colors.redAccent.withOpacity(0.5),
            strokeColor: Colors.redAccent,
            strokeWidth: 3),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygonIdCounter++;
    setState(() {
      _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: Colors.yellow,
        fillColor: Colors.yellow.withOpacity(0.15),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

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
          'Map 3 Polygon',
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
            circles: _circles,
            polygons: _polygons,
            onCameraMove: _onCameraMove,
            trafficEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            // initialCameraPosition: _cameraPosition,
            initialCameraPosition: CameraPosition(
              target: latlong,
              zoom: 11.0,
            ),
            onTap: (point) {
              if (_isPolygon) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              } else if (_isMarker) {
                setState(() {
                  _markers.clear();
                  _setMarker(point);
                });
              } else if (_isCircle) {
                setState(() {
                  _circles.clear();
                  _setCircle(point);
                });
              }
            },
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.black54,
                  onPressed: () {
                    _isPolygon = true;
                    _isMarker = false;
                    _isCircle = false;
                  },
                  child: Text(
                    'Polygon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.black54,
                  onPressed: () {
                    _isPolygon = false;
                    _isMarker = true;
                    _isCircle = false;
                  },
                  child: Text(
                    'Marker',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.black54,
                  onPressed: () {
                    _isPolygon = false;
                    _isMarker = false;
                    _isCircle = true;
                    radius = 50;
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[900],
                          title: Text(
                            'Choose the radius (m)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          content: TextField(
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            decoration: InputDecoration(
                                icon: Icon(Icons.zoom_out_map),
                                hintText: 'Ex: 100',
                                suffixText: 'meters'),
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (input) {
                              setState(() {
                                radius = double.parse(input);
                              });
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'Ok',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Circle',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
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
