import 'package:filmax/consumerprovider/common/tidakdigunakan/data_mapper.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/restaurant_provider.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/search_restaurant_provider.dart' as search;
import 'package:filmax/consumerprovider/ui/tidakdigunakan/favorite_list.dart';
import 'package:filmax/consumerprovider/ui/tidakdigunakan/search.dart';
import 'package:filmax/consumerprovider/ui/tidakdigunakan/settings_page.dart';
import 'package:filmax/consumerprovider/utils/background_service.dart';
import 'package:filmax/consumerprovider/utils/tidakdigunakan/notification_helper.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/alert_connection.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/card_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'restaurant_detail.dart';

class BerandaListPage extends StatefulWidget {
  static const routeName = '/article_list';

  const BerandaListPage();

  @override
  _BerandaListPageState createState() => _BerandaListPageState();
}

class _BerandaListPageState extends State<BerandaListPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Angkringan',
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
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 26.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteList(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 26.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),

      body:
      Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return
              Center(
                  child: CircularProgressIndicator()
              );
          } else if (state.state == ResultState.HasData) {
                return
                  Center(
                    child: ListView.builder(
                      padding: EdgeInsets.all(3.0),
                      itemCount: state.result?.restaurants.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1.7,
                          child: CardArticle(
                            article:  DataMapper().restaurantElementToFavorite(state.result!.restaurants[index]),
                          ),
                        );
                      },
                    ),
                  );
          } else if (state.state == ResultState.NoData) {
            return Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(state.message,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),))
            ;
          } else if (state.state == ResultState.Error) {
            return Center(
              child:
              Column(
                children: <Widget>[
                  AlertConnection(),
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(state.message,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),))
                  ,],),);
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}