import 'package:flutter/cupertino.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    _search();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';
  final TextEditingController _controller = TextEditingController();

  String get message => _message;
  RestaurantsResult get result => _restaurantsResult;
  ResultState get state => _state;
  TextEditingController get controller => _controller;

  Future<dynamic> _search() async {
    try {
      if (_controller.text.isEmpty) {
        _state = ResultState.noSearch;
        notifyListeners();
        return;
      }

      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.searchRestaurant(_controller.text);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message =
            'No restaurant found with the current name/category/menu!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Something went wrong! Check your internet connection!";
    }
  }

  void updateData() => _search();
}
