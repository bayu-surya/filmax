import 'dart:ui';

import 'package:filmax/consumerprovider/common/styles.dart';
import 'package:filmax/consumerprovider/common/tidakdigunakan/data_mapper.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/search_restaurant_provider.dart';
import 'package:filmax/consumerprovider/ui/tidakdigunakan/favorite_list.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/alert_connection.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/card_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const routeName = '/search';

  const Search();

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String _searchString = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
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
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                SizedBox(
                    width : 10.0),
                Expanded(
                  child:
                  Stack(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onChanged: (text) {
                          _searchString=text;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: primaryColor,
                            size: 26.0,
                          ),
                          onPressed: () {
                            if(_searchString!="") {
                              Provider.of<SearchRestaurantProvider>(context, listen: false).fetchAllArticle(_searchString);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width : 10.0),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Consumer<SearchRestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        padding: EdgeInsets.all(3.0),
                        itemCount: state.result!.restaurants.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 1.7,
                            child: CardArticle(
                              article: DataMapper().restaurantToFavorite(state.result!.restaurants[index]),
                            ),
                          );
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(state.message,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)),);
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
                                ),),),],),);
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}