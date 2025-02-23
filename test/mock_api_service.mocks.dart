import 'dart:async' as i7;

import 'package:mockito/mockito.dart' as i1;
import 'package:restaurant_app/data/api/api_service.dart' as i6;
import 'package:restaurant_app/data/model/add_review_response.dart' as i5;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart'
    as i3;
import 'package:restaurant_app/data/model/restaurant_list_response.dart' as i2;
import 'package:restaurant_app/data/model/restaurant_search_response.dart'
    as i4;

class _FakeRestaurantListResponse extends i1.SmartFake
    implements i2.RestaurantListResponse {
  _FakeRestaurantListResponse(super.parent, super.parentInvocation);
}

class _FakeRestaurantDetailResponse extends i1.SmartFake
    implements i3.RestaurantDetailResponse {
  _FakeRestaurantDetailResponse(super.parent, super.parentInvocation);
}

class _FakeRestaurantSearchResponse extends i1.SmartFake
    implements i4.RestaurantSearchResponse {
  _FakeRestaurantSearchResponse(super.parent, super.parentInvocation);
}

class _FakeAddReviewResponse extends i1.SmartFake
    implements i5.AddReviewResponse {
  _FakeAddReviewResponse(super.parent, super.parentInvocation);
}

/// A class which mocks [ApiServices].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiServices extends i1.Mock implements i6.ApiServices {
  MockApiServices() {
    i1.throwOnMissingStub(this);
  }

  @override
  i7.Future<i2.RestaurantListResponse> getRestaurantList() =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurantList, []),
            returnValue: i7.Future<i2.RestaurantListResponse>.value(
              _FakeRestaurantListResponse(
                this,
                Invocation.method(#getRestaurantList, []),
              ),
            ),
          )
          as i7.Future<i2.RestaurantListResponse>);

  @override
  i7.Future<i3.RestaurantDetailResponse> getRestaurantDetail(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurantDetail, [id]),
            returnValue: i7.Future<i3.RestaurantDetailResponse>.value(
              _FakeRestaurantDetailResponse(
                this,
                Invocation.method(#getRestaurantDetail, [id]),
              ),
            ),
          )
          as i7.Future<i3.RestaurantDetailResponse>);

  @override
  i7.Future<i4.RestaurantSearchResponse> searchRestaurant(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchRestaurant, [query]),
            returnValue: i7.Future<i4.RestaurantSearchResponse>.value(
              _FakeRestaurantSearchResponse(
                this,
                Invocation.method(#searchRestaurant, [query]),
              ),
            ),
          )
          as i7.Future<i4.RestaurantSearchResponse>);

  @override
  i7.Future<i5.AddReviewResponse> addReview(
    String? id,
    String? name,
    String? review,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addReview, [id, name, review]),
            returnValue: i7.Future<i5.AddReviewResponse>.value(
              _FakeAddReviewResponse(
                this,
                Invocation.method(#addReview, [id, name, review]),
              ),
            ),
          )
          as i7.Future<i5.AddReviewResponse>);
}
