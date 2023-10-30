import 'package:flutter/cupertino.dart';
import 'package:myrestaurant/data/db/database_helper.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get favorites => _restaurants;

  void _getFavorites() async {
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'You dont have any favorite restaurants';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error happened when insert into favorites.\nError message: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    return await databaseHelper.isFavorite(id);
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error happened when remove from favorites.\nError message: $e';
      notifyListeners();
    }
  }
}
