import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmax/core/common/styles.dart';
import 'package:filmax/core/util/data_mapper.dart' as mapper;
import 'package:filmax/core/util/language_manager.dart';
import 'package:filmax/core/util/localizations.dart';
import 'package:filmax/presentation/bloc/movienow/movie_now_bloc.dart' as now;
import 'package:filmax/presentation/bloc/moviepopular/bloc.dart';
import 'package:filmax/presentation/bloc/moviepopular/movie_popular_bloc.dart';
import 'package:filmax/presentation/bloc/movietop/movie_top_bloc.dart' as top;
import 'package:filmax/presentation/bloc/movieupcoming/movie_upcoming_bloc.dart'
    as upcoming;
import 'package:filmax/presentation/pages/map/map_main_page.dart';
import 'package:filmax/presentation/widgets/alert_connection.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:filmax/presentation/widgets/card_nowplaying.dart';
import 'package:filmax/presentation/widgets/card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home2';

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? currentBackPressTime;
  FToast fToast = FToast();

  @override
  void initState() {
    BlocProvider.of<MoviePopularBloc>(context).add(GetDataForPopular());
    BlocProvider.of<top.MovieTopBloc>(context).add(top.GetDataForTop());
    BlocProvider.of<now.MovieNowBloc>(context).add(now.GetDataForNow());
    BlocProvider.of<upcoming.MovieUpcomingBloc>(context)
        .add(upcoming.GetDataForUpcoming());
    super.initState();

    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 'Home',
          AppLocalizations.of(context).trans(LanguageManager.home)!,
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
                Navigator.pushNamed(context, MapMainPage.routeName);
                _showToast();
              },
              child: Icon(
                Icons.map,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: WillPopScope(
        child: SingleChildScrollView(
          // child: BlocProvider(
          //   create: (_) => sl<MoviePopularBloc>(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              CarouselSlider(
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 1.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 0.1),
                            decoration: BoxDecoration(color: primaryColor),
                            child: Center(
                              child: Text(
                                'urutan $i',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 9 / 12,
                  viewportFraction: 0.6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  // onPageChanged: callbackFunction,
                ),
              ),
              // CarouselSlider.builder(
              //   options: CarouselOptions(height: 400.0),
              //   itemCount: 15,
              //   itemBuilder: (BuildContext context, int itemIndex,
              //           int pageViewIndex) =>
              //       Container(
              //     child: Text(itemIndex.toString()),
              //   ),
              // ),
              _tittleListView("Now Playing"),
              Container(
                height: 270,
                child: BlocBuilder<now.MovieNowBloc, now.MovieNowState>(
                  builder: (context, state) {
                    if (state is now.Empty) {
                      return _buildContainerNoData("Empty");
                    } else if (state is now.Loading) {
                      return CardShimmer();
                    } else if (state is now.Loaded) {
                      return Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(3.0),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return CardArticle(
                              article: mapper.DataMapper()
                                  .entitieToModel(state.data[index]),
                              jenis: '',
                            );
                          },
                        ),
                      );
                    } else if (state is now.Error) {
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
                child: BlocBuilder<top.MovieTopBloc, top.MovieTopState>(
                  builder: (context, state) {
                    if (state is top.Empty) {
                      return _buildContainerNoData("Empty");
                    } else if (state is top.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is top.Loaded) {
                      return Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(3.0),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return CardArticle(
                              article: mapper.DataMapper()
                                  .entitieToModel(state.data[index]),
                              jenis: '',
                            );
                          },
                        ),
                      );
                    } else if (state is top.Error) {
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
                child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return _buildContainerNoData("Empty");
                    } else if (state is Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is Loaded) {
                      return Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(3.0),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return CardArticle(
                              article: mapper.DataMapper()
                                  .entitieToModel(state.data[index]),
                              jenis: '',
                            );
                          },
                        ),
                      );
                    } else if (state is Error) {
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
                child: BlocBuilder<upcoming.MovieUpcomingBloc,
                    upcoming.MovieUpcomingState>(
                  builder: (context, state) {
                    if (state is upcoming.Empty) {
                      return _buildContainerNoData("Empty");
                    } else if (state is upcoming.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is upcoming.Loaded) {
                      return Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(3.0),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return CardArticle(
                              article: mapper.DataMapper()
                                  .entitieToModel(state.data[index]),
                              jenis: '',
                            );
                          },
                        ),
                      );
                    } else if (state is upcoming.Error) {
                      return _buildCenter(state.message);
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        onWillPop: _onWillPopA,
      ),
    );
  }

  //keluar aplikasi
  Future<bool> _onWillPopA() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tekan 2 kali untuk keluar aplikasi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  Future<bool> _onWillPopB() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Peringatan"),
            content: Text(
              "Apakah anda akan keluar aplikasi ?",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Tidak"),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // if (Platform.isAndroid) {
                  // SystemNavigator.pop();
                  // } else if (Platform.isIOS) {
                  //   exit(0);
                  // }
                },
                textColor: primaryColor,
                child: Text('Ok'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Container _buildContainerNoData(String message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Center _buildCenter(String message) {
    return Center(
      child: Column(
        children: <Widget>[
          AlertConnection(),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _tittleListView(String tittle) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Text(
            tittle,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: Text(
              "MORE",
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

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Anda membuka map"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }
}
