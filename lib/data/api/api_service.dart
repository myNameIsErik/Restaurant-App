import 'dart:convert';
import 'package:restaurant_app/data/model/add_review_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_search_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["restaurants"] == null) {
        return RestaurantSearchResponse(
            error: true, founded: 0, restaurants: []);
      }

      return RestaurantSearchResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<AddReviewResponse> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      body: {
        'id': id,
        'name': name,
        'review': review,
      },
    );

    if (response.statusCode == 200) {
      return AddReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
