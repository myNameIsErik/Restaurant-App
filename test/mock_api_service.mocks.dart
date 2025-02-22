import 'dart:async' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/data/api/api_service.dart' as _i6;
import 'package:restaurant_app/data/model/add_review_response.dart' as _i5;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart'
    as _i3;
import 'package:restaurant_app/data/model/restaurant_list_response.dart' as _i2;
import 'package:restaurant_app/data/model/restaurant_search_response.dart'
    as _i4;

class _FakeRestaurantListResponse_0 extends _i1.SmartFake
    implements _i2.RestaurantListResponse {
  _FakeRestaurantListResponse_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeRestaurantDetailResponse_1 extends _i1.SmartFake
    implements _i3.RestaurantDetailResponse {
  _FakeRestaurantDetailResponse_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeRestaurantSearchResponse_2 extends _i1.SmartFake
    implements _i4.RestaurantSearchResponse {
  _FakeRestaurantSearchResponse_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeAddReviewResponse_3 extends _i1.SmartFake
    implements _i5.AddReviewResponse {
  _FakeAddReviewResponse_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [ApiServices].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiServices extends _i1.Mock implements _i6.ApiServices {
  MockApiServices() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.RestaurantListResponse> getRestaurantList() =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurantList, []),
            returnValue: _i7.Future<_i2.RestaurantListResponse>.value(
              _FakeRestaurantListResponse_0(
                this,
                Invocation.method(#getRestaurantList, []),
              ),
            ),
          )
          as _i7.Future<_i2.RestaurantListResponse>);

  @override
  _i7.Future<_i3.RestaurantDetailResponse> getRestaurantDetail(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurantDetail, [id]),
            returnValue: _i7.Future<_i3.RestaurantDetailResponse>.value(
              _FakeRestaurantDetailResponse_1(
                this,
                Invocation.method(#getRestaurantDetail, [id]),
              ),
            ),
          )
          as _i7.Future<_i3.RestaurantDetailResponse>);

  @override
  _i7.Future<_i4.RestaurantSearchResponse> searchRestaurant(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchRestaurant, [query]),
            returnValue: _i7.Future<_i4.RestaurantSearchResponse>.value(
              _FakeRestaurantSearchResponse_2(
                this,
                Invocation.method(#searchRestaurant, [query]),
              ),
            ),
          )
          as _i7.Future<_i4.RestaurantSearchResponse>);

  @override
  _i7.Future<_i5.AddReviewResponse> addReview(
    String? id,
    String? name,
    String? review,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addReview, [id, name, review]),
            returnValue: _i7.Future<_i5.AddReviewResponse>.value(
              _FakeAddReviewResponse_3(
                this,
                Invocation.method(#addReview, [id, name, review]),
              ),
            ),
          )
          as _i7.Future<_i5.AddReviewResponse>);
}
