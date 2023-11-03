import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myrestaurant/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> listRestaurants() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "list");
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }

  Future<RestaurantsResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "detail");
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantsResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "search");
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<RestaurantReview> addReview(String id, String name, String review) async {
    Map<String, String> reqHeader = {
       'Content-Type': 'application/json',
     };
    String reqBody = jsonEncode({"id": id, "name": name, "review": review});

    final response = await http.post(Uri.parse("$_baseUrl/review"), headers: reqHeader, body: reqBody);

    if (response.statusCode == 201) {
      return RestaurantReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
