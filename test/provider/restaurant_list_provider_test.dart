import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

// Import file mock yang dihasilkan otomatis oleh Mockito
import '../mock_api_service.mocks.dart';

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestaurantListProvider(mockApiService);
  });

  final fakeResponse = RestaurantListResponse(
    error: false,
    message: "Success",
    count: 1,
    restaurants: [
      Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description: "Restoran terkenal di Medan",
        city: "Medan",
        address: "Jalan Merdeka No. 10, Medan", // Tambahkan address
        pictureId: "14",
        categories: [Category(name: "Western")], // Tambahkan categories
        menus: Menus(
          // Tambahkan menus
          foods: [Category(name: "Steak")],
          drinks: [Category(name: "Wine")],
        ),
        rating: 4.2,
        customerReviews: [
          // Tambahkan customerReviews
          CustomerReview(
              name: "John Doe", review: "Makanannya enak!", date: "2024-02-19"),
        ],
      ),
    ],
  );

  group("RestaurantListProvider", () {
    test("State awal harus didefinisikan sebagai RestaurantListNoneState", () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test(
        "Harus mengembalikan daftar restoran ketika pengambilan data API berhasil",
        () async {
      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => fakeResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      final state = provider.resultState as RestaurantListLoadedState;
      expect(state.data, isNotEmpty);
      expect(state.data.first.name, "Melting Pot");
    });

    test("Harus mengembalikan error ketika pengambilan data API gagal",
        () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception("Network Error"));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, "Exception: Network Error");
    });
  });
}
