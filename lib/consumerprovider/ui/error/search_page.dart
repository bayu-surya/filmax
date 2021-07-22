import 'package:dio/dio.dart';
import 'package:filmax/consumerprovider/common/data_mapper.dart';
import 'package:filmax/consumerprovider/provider/movienow_provider.dart';
import 'package:filmax/consumerprovider/provider/moviepopular_provider.dart';
import 'package:filmax/consumerprovider/provider/movietop_provider.dart';
import 'package:filmax/consumerprovider/provider/movieupcoming_provider.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/search_restaurant_provider.dart' as search;
import 'package:filmax/consumerprovider/ui/tidakdigunakan/search.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:filmax/consumerprovider/widgets/app_drawer.dart';
import 'package:filmax/consumerprovider/widgets/card_nowplaying.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/alert_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );

  @override
  void initState() {
    // this._getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
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
                  Provider.of<search.SearchRestaurantProvider>(context, listen: false).empty();
                  Navigator.pushNamed(context, Search.routeName);
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),

      drawer: AppDrawer(),
      body: _buildHome(),
    );
  }

  SingleChildScrollView _buildHome() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _tittleListView("Now Playing"),

          Container(
            height: 270,
            child: Consumer<MovieNowProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child:CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(3.0),
                      itemCount: state.result!.results.length,
                      itemBuilder: (context, index) {
                        return CardArticle(
                            article: DataMapper().movieNowToPopuler(state.result!.results[index]), jenis: '',
                          );
                      },
                    ),
                  );
                } else if (state.state == ResultState.NoData) {
                  return _buildContainerNoData(state.message);
                } else if (state.state == ResultState.Error) {
                  return _buildCenter(state.message);
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),

          _tittleListView("Top Rated"),

          Container(
            height: 270,
            child: Consumer<MovieTopProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(
                      child:CircularProgressIndicator()
                  );
                } else if (state.state == ResultState.HasData) {
                  return Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(3.0),
                      itemCount: state.result!.results.length,
                      itemBuilder: (context, index) {
                        return CardArticle(
                            article: DataMapper().movieTopToPopuler(state.result!.results[index]), jenis: '',
                          );
                      },
                    ),
                  );
                } else if (state.state == ResultState.NoData) {
                  return _buildContainerNoData(state.message);
                } else if (state.state == ResultState.Error) {
                  return _buildCenter(state.message);
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),

          _tittleListView("Popular"),

          Container(
            height: 270,
            child: Consumer<MoviePopularProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child:CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(3.0),
                      itemCount: state.result!.results.length,
                      itemBuilder: (context, index) {
                        return CardArticle(
                            article:  state.result!.results[index], jenis: '',
                          );
                      },
                    ),
                  );
                } else if (state.state == ResultState.NoData) {
                  return _buildContainerNoData(state.message);
                } else if (state.state == ResultState.Error) {
                  return _buildCenter(state.message);
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),

          _tittleListView("Upcoming"),

          Container(
            height: 270,
            child: Consumer<MovieUpcomingProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child:CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(3.0),
                      itemCount: state.result!.results.length,
                      itemBuilder: (context, index) {
                        return CardArticle(
                            article: DataMapper().movieUpcomingToPopuler(state.result!.results[index]), jenis: '',
                          );
                      },
                    ),
                  );
                } else if (state.state == ResultState.NoData) {
                  return _buildContainerNoData(state.message);
                } else if (state.state == ResultState.Error) {
                  return _buildCenter(state.message);
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildContainerNoData(String message) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),));
  }

  Center _buildCenter(String message) {
    return Center(
      child:
      Column(
        children: <Widget>[
          AlertConnection(),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),))
          ,],),);
  }

  Row _tittleListView(String tittle) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left:20, top:10, bottom: 10),
          child: Text( tittle,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right:20, top:10, bottom: 10),
            child:
            Text("MORE",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}

class ExamplePage extends StatefulWidget {
  static const routeName = '/example';

  const ExamplePage();

  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      // resizeToAvoidBottomPadding: false,
    );
  }

  AppBar _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search Example' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = [];
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }


}