import 'dart:convert';

class Article {
  String location;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    required this.location,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Article.fromJson(Map<String, dynamic> article) {
  //   location = article['location'];
  //   title = article['title'];
  //   description = article['description'];
  //   url = article['url'];
  //   urlToImage = article['urlToImage'];
  //   publishedAt = article['publishedAt'];
  //   content = article['content'];
  // }

  factory Article.fromJson(Map<String, dynamic> article) => Article(
      location : article['location'],
      title : article['title'],
      description : article['description'],
      url : article['url'],
      urlToImage : article['urlToImage'],
      publishedAt : article['publishedAt'],
      content : article['content'],
  );
}

List<Article> parseArticles(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Article.fromJson(json)).toList();
}
