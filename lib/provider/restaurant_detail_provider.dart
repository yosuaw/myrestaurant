import 'package:flutter/cupertino.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late Restaurant _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  Restaurant get result => _restaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data fetched with current restaurant ID!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant.restaurants[0];
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Error Occured!\nCheck your internet connection and try again later!";
    }
  }
}
