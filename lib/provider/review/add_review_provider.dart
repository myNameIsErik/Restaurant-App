import 'package:flutter/widgets.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/add_review_result_state.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  AddReviewProvider(this._apiServices);

  AddReviewResultState _resultState = AddReviewNoneState();
  AddReviewResultState get resultState => _resultState;

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = AddReviewLoadingState();
      notifyListeners();

      final response = await _apiServices.addReview(id, name, review);

      if (response.error) {
        _resultState = AddReviewErrorState(response.message);
      } else {
        _resultState = AddReviewLoadedState(response.customerReviews);
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = AddReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}
