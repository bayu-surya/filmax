import 'package:filmax/core/common/navigation.dart';
import 'package:filmax/core/util/api_service.dart';
import 'package:filmax/data/models/movie_popular.dart';
import 'package:filmax/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

class CardArticle extends StatelessWidget {
  final Result article;
  final String jenis;

  const CardArticle({
    Key? key,
    required this.article,
    required this.jenis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.intentWithData(
            MovieDetailPage.routeName, article.id.toString());
      },
      child: Card(
        elevation: 1.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
              child: Image.network(
                ApiService.baseUrlImage + article.posterPath,
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  Text(
                    article.releaseDate.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
