import 'package:filmax/consumerprovider/common/tidakdigunakan/data_mapper.dart';
import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/detail_restaurant.dart' as restaurant;
import 'package:filmax/consumerprovider/provider/database_provider.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/detail_restaurant_provider.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/alert_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final String id;

  const RestaurantDetailPage({
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<DetailRestaurantProvider>(context, listen: false).fetchAllArticle(id.toString());

    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Scaffold(
            appBar: _appBar(''),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state.state == ResultState.HasData) {
          return Scaffold(
            appBar: _appBar2(state.result),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: state.result!.id,
                    child: Image.network(
                        ApiService.baseUrlImage+"medium/"+state.result!.pictureId
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.result!.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Text('Rating: ${state.result!.rating}'),
                        SizedBox(height: 10),
                        Text('Lokasi: ${state.result!.address}'),
                        Divider(color: Colors.grey),
                        Text(
                          state.result!.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Menu makanan",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        LimitedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.all(3.0),
                                  itemCount: state.result!.menus.foods.length,
                                  itemBuilder: (context, index) {
                                    return Text("- "+state.result!.menus.foods[index].name);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Menu minuman",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        LimitedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.all(3.0),
                                  itemCount: state.result!.menus.drinks.length,
                                  itemBuilder: (context, index) {
                                    return Text("- "+state.result!.menus.drinks[index].name);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Review pelanggan",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        LimitedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(vertical: 3.0),
                                  itemCount: state.result!.customerReviews.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 1.7,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Text(state.result!.customerReviews[index].name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(height: 5),
                                              Text(state.result!.customerReviews[index].date ,
                                                style: TextStyle(
                                                    fontSize: 12),
                                              ),
                                              SizedBox(height: 5),
                                              Text(state.result!.customerReviews[index].review ,
                                                style: TextStyle(
                                                    fontSize: 12),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.NoData) {
          return _buildScaffold("Detail Restaurant", state.message);
        } else if (state.state == ResultState.Error) {
          return _buildScaffold2("Detail Restaurant", state.message);
        } else {
          return _buildScaffold("Detail Restaurant", '');
        }
      },
    );
  }

  Scaffold _buildScaffold(String tittle, String message) {
    return Scaffold(
        appBar: _appBar(tittle),
        body: Center(child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)),)
    );
  }

  Scaffold _buildScaffold2(String tittle, String message) {
    return Scaffold(
      appBar: _appBar(tittle),
      body:  Center(
        child:
        Column(
          children: <Widget>[
            AlertConnection(),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(message,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),)),
          ],),),
    );
  }

  AppBar _appBar(String tittle) {
    return AppBar(
      title: Text(tittle,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
    );
  }

  AppBar _appBar2(restaurant.Restaurant? state) {
    return AppBar(
      title: Text(state!.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
      actions: <Widget>[
        Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<bool>(
              future: provider.isFavorite(state.id),
              builder: (context, snapshot) {
                var isFavorite = snapshot.data ?? false;
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.redAccent : Colors.white,
                    size: 26.0,
                  ),
                  onPressed: () { isFavorite ?
                  provider.removeFavorite(state.id) :
                  provider.addFavorite(DataMapper().restaurantDetailToFavorite(state));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

