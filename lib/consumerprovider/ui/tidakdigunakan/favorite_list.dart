import 'package:filmax/consumerprovider/provider/database_provider.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/card_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatelessWidget {

  const FavoriteList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
      Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.HasData) {
            return ListView.builder(
              padding: EdgeInsets.all(3.0),
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 1.7,
                    child: CardArticle(article: provider.restaurants[index]),
                );
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}