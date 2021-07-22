import 'package:filmax/consumerprovider/provider/tidakdigunakan/search_restaurant_provider.dart'
    as search;
import 'package:filmax/consumerprovider/ui/tidakdigunakan/search.dart';
import 'package:filmax/consumerprovider/widgets/app_drawer.dart';
import 'package:filmax/consumerprovider/widgets/card_nowplaying.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/alert_connection.dart';
import 'package:filmax/core/util/data_mapper.dart' as mapper;
import 'package:filmax/presentation/bloc/movienow/movie_now_bloc.dart' as now;
import 'package:filmax/presentation/bloc/moviepopular/bloc.dart';
import 'package:filmax/presentation/bloc/moviepopular/movie_popular_bloc.dart';
import 'package:filmax/presentation/bloc/movietop/movie_top_bloc.dart' as top;
import 'package:filmax/presentation/bloc/movieupcoming/movie_upcoming_bloc.dart'
    as upcoming;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home2';

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<MoviePopularBloc>(context).add(GetDataForPopular());
    BlocProvider.of<top.MovieTopBloc>(context).add(top.GetDataForTop());
    BlocProvider.of<now.MovieNowBloc>(context).add(now.GetDataForNow());
    BlocProvider.of<upcoming.MovieUpcomingBloc>(context)
        .add(upcoming.GetDataForUpcoming());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
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
                  Provider.of<search.SearchRestaurantProvider>(context,
                          listen: false)
                      .empty();
                  Navigator.pushNamed(context, Search.routeName);
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        // child: BlocProvider(
        //   create: (_) => sl<MoviePopularBloc>(),
        child: Column(
          children: <Widget>[
            _tittleListView("Now Playing"),
            Container(
              height: 270,
              child: BlocBuilder<now.MovieNowBloc, now.MovieNowState>(
                builder: (context, state) {
                  if (state is now.Empty) {
                    return Text(
                      'Empty',
                    );
                  } else if (state is now.Loading) {
                    return Text(
                      'Loading',
                    );
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
                    return Text(
                      state.message,
                    );
                  } else {
                    return Text(
                      'Lain',
                    );
                  }
                },
              ),
            ),
            // Container(
            //   height: 270,
            //   child: Consumer<MovieNowProvider>(
            //     builder: (context, state, _) {
            //       if (state.state == ResultState.Loading) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (state.state == ResultState.HasData) {
            //         return Center(
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             padding: EdgeInsets.all(3.0),
            //             itemCount: state.result!.results.length,
            //             itemBuilder: (context, index) {
            //               return CardArticle(
            //                 article: DataMapper().movieNowToPopuler(
            //                     state.result!.results[index]),
            //                 jenis: '',
            //               );
            //             },
            //           ),
            //         );
            //       } else if (state.state == ResultState.NoData) {
            //         return _buildContainerNoData(state.message);
            //       } else if (state.state == ResultState.Error) {
            //         return _buildCenter(state.message);
            //       } else {
            //         return Center(child: Text(''));
            //       }
            //     },
            //   ),
            // ),
            _tittleListView("Top Rated"),
            Container(
              height: 270,
              child: BlocBuilder<top.MovieTopBloc, top.MovieTopState>(
                builder: (context, state) {
                  if (state is top.Empty) {
                    return Text(
                      'Empty',
                    );
                  } else if (state is top.Loading) {
                    return Text(
                      'Loading',
                    );
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
                    return Text(
                      state.message,
                    );
                  } else {
                    return Text(
                      'Lain',
                    );
                  }
                },
              ),
            ),
            // Container(
            //   height: 270,
            //   child: Consumer<MovieTopProvider>(
            //     builder: (context, state, _) {
            //       if (state.state == ResultState.Loading) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (state.state == ResultState.HasData) {
            //         return Center(
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             padding: EdgeInsets.all(3.0),
            //             itemCount: state.result!.results.length,
            //             itemBuilder: (context, index) {
            //               return CardArticle(
            //                 article: DataMapper().movieTopToPopuler(
            //                     state.result!.results[index]),
            //                 jenis: '',
            //               );
            //             },
            //           ),
            //         );
            //       } else if (state.state == ResultState.NoData) {
            //         return _buildContainerNoData(state.message);
            //       } else if (state.state == ResultState.Error) {
            //         return _buildCenter(state.message);
            //       } else {
            //         return Center(child: Text(''));
            //       }
            //     },
            //   ),
            // ),
            _tittleListView("Popular"),
            Container(
              height: 270,
              child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Text(
                      'Empty',
                    );
                  } else if (state is Loading) {
                    return Text(
                      'Loading',
                    );
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
                    return Text(
                      state.message,
                    );
                  } else {
                    return Text(
                      'Lain',
                    );
                  }
                },
              ),

              // Consumer<MoviePopularProvider>(
              //   builder: (context, state, _) {
              //     if (state.state == ResultState.Loading) {
              //       return Center(child: CircularProgressIndicator());
              //     } else if (state.state == ResultState.HasData) {
              //       return Center(
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           padding: EdgeInsets.all(3.0),
              //           itemCount: state.result!.results.length,
              //           itemBuilder: (context, index) {
              //             return CardArticle(
              //               article: state.result!.results[index],
              //               jenis: '',
              //             );
              //           },
              //         ),
              //       );
              //     } else if (state.state == ResultState.NoData) {
              //       return _buildContainerNoData(state.message);
              //     } else if (state.state == ResultState.Error) {
              //       return _buildCenter(state.message);
              //     } else {
              //       return Center(child: Text(''));
              //     }
              //   },
              // ),
            ),
            _tittleListView("Upcoming"),
            Container(
              height: 270,
              child: BlocBuilder<upcoming.MovieUpcomingBloc,
                  upcoming.MovieUpcomingState>(
                builder: (context, state) {
                  if (state is upcoming.Empty) {
                    return Text(
                      'Empty',
                    );
                  } else if (state is upcoming.Loading) {
                    return Text(
                      'Loading',
                    );
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
                    return Text(
                      state.message,
                    );
                  } else {
                    return Text(
                      'Lain',
                    );
                  }
                },
              ),
            ),
            // Container(
            //   height: 270,
            //   child: Consumer<MovieUpcomingProvider>(
            //     builder: (context, state, _) {
            //       if (state.state == ResultState.Loading) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (state.state == ResultState.HasData) {
            //         return Center(
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             padding: EdgeInsets.all(3.0),
            //             itemCount: state.result!.results.length,
            //             itemBuilder: (context, index) {
            //               return CardArticle(
            //                 article: DataMapper().movieUpcomingToPopuler(
            //                     state.result!.results[index]),
            //                 jenis: '',
            //               );
            //             },
            //           ),
            //         );
            //       } else if (state.state == ResultState.NoData) {
            //         return _buildContainerNoData(state.message);
            //       } else if (state.state == ResultState.Error) {
            //         return _buildCenter(state.message);
            //       } else {
            //         return Center(child: Text(''));
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      // ),
    );
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
}
