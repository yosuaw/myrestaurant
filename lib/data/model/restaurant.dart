import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Map<String, dynamic> menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"];
    menus = json["menus"];
  }

  static List<Restaurant> parseRestaurants(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json)['restaurants'];
    return parsed.map((json) => Restaurant.fromJson(json)).toList();
  }
}
