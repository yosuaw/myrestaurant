import 'package:flutter/cupertino.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/utils/result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantReviewProvider({required this.apiService});

  late List<CustomerReview> _restaurantReviews;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<CustomerReview> get restaurantReviews => _restaurantReviews;
  ResultState get state => _state;

  Future<dynamic> addRestaurantReview(
      String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.addReview(id, name, review);

      if (result.customerReviews.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Failed to add review!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantReviews = result.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Error Occured!\nCheck your internet connection and try again later!";
    }
  }
}
