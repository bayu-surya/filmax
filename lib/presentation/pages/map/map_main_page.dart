import 'package:filmax/presentation/pages/map/map_page.dart';
import 'package:filmax/presentation/pages/map/map_page_2.dart';
import 'package:filmax/presentation/pages/map/map_page_3.dart';
import 'package:flutter/material.dart';

class MapMainPage extends StatefulWidget {
  static const routeName = '/map_main';

  const MapMainPage();

  @override
  _MapMainPageState createState() => _MapMainPageState();
}

class _MapMainPageState extends State<MapMainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    MapPage(),
    Map2Page(),
    Map3Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // selectedFontSize: 20,
        // selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
        // selectedItemColor: Colors.amberAccent,
        // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        // unselectedItemColor: Colors.deepOrangeAccent,
        // elevation: 1,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location_outlined),
            label: 'Map 3',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}
