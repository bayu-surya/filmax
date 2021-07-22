import 'package:filmax/consumerprovider/common/navigation.dart';
import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/favorite.dart';
import 'package:filmax/consumerprovider/provider/database_provider.dart';
import 'package:filmax/consumerprovider/ui/tidakdigunakan/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {

  final Favorite article;

  const CardArticle({
     Key? key, required this.article,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(article.id.toString()),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              onTap: () {
                print("aaaaaaaaaaa"+article.id);
                Navigation.intentWithData(
                    RestaurantDetailPage.routeName, article.id);
              },
              leading: article.pictureId == null
                  ? Container(width: 100, child: Icon(Icons.error))
                  : Hero(
                tag: article.id,
                child: Image.network(
                  ApiService.baseUrlImage+"small/"+article.pictureId,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(article.name, ),
              subtitle: Text(article.city),
              trailing: IconButton(
                icon:
                Icon(
                  Icons.favorite,
                  color:  isFavorite ? Colors.redAccent : Colors.grey,
                  size: 26.0,
                ),
                onPressed: () { isFavorite ?
                provider.removeFavorite(article.id.toString()) :
                provider.addFavorite(article);
                },
              ),
            );
          },
        );
      },
    );
  }
}
