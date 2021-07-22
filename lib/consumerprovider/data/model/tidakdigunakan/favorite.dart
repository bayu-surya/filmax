class Favorite {
  Favorite({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "picture_id": pictureId,
    "city": city,
    "rating": rating,
  };

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["picture_id"],
    city: json["city"],
    rating: json["rating"],
  );
}