class RestaurantsResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json, String method) {
    if (method == "list") {
      return RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((e) => Restaurant.fromJson(e))),
      );
    } else if (method == "detail") {
      return RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: 1,
        restaurants: [Restaurant.fromJson(json["restaurant"])],
      );
    } else {
      return RestaurantsResult(
        error: json["error"],
        message: "",
        count: json["founded"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((e) => Restaurant.fromJson(e))),
      );
    }
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<Category>? categories;
  final Menus? menus;
  final double rating;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"] ?? "",
        pictureId: json["pictureId"],
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
        menus: json["menus"] != null
            ? Menus.fromJson(json["menus"])
            : Menus(foods: [], drinks: []),
        rating: json["rating"].toDouble(),
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : [],
      );
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}
