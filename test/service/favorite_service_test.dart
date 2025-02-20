import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/favorite_restaurant.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late FavoriteService favoriteService;

  // Data dummy restoran favorit
  final favoriteRestaurant = FavoriteRestaurant(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    city: "Medan",
    address: "Jl. ABC No. 123",
    pictureId: "14",
    rating: 4.2,
  );

  setUpAll(() {
    // Inisialisasi database FFI untuk testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    favoriteService = FavoriteService();
    await favoriteService.database;
  });

  tearDown(() async {
    await favoriteService.database;
  });

  group('FavoriteService Tests', () {
    test('Menambahkan restoran ke daftar favorit', () async {
      final result = await favoriteService.insertFavorite(favoriteRestaurant);
      expect(result, isNonZero);
    });

    test('Mengambil daftar restoran favorit', () async {
      await favoriteService.insertFavorite(favoriteRestaurant);
      final favorites = await favoriteService.getFavorites();

      expect(favorites, isNotEmpty);
      expect(favorites.first.id, equals(favoriteRestaurant.id));
      expect(favorites.first.name, equals(favoriteRestaurant.name));
    });

    test('Menghapus restoran dari daftar favorit', () async {
      await favoriteService.insertFavorite(favoriteRestaurant);

      final deleteResult =
          await favoriteService.deleteFavorite(favoriteRestaurant.id);
      expect(deleteResult, equals(1));

      final favorites = await favoriteService.getFavorites();
      expect(favorites, isEmpty);
    });

    test('Mengecek apakah restoran ada dalam daftar favorit', () async {
      await favoriteService.insertFavorite(favoriteRestaurant);

      final isFav = await favoriteService.isFavorite(favoriteRestaurant.id);
      expect(isFav, isTrue);

      await favoriteService.deleteFavorite(favoriteRestaurant.id);
      final isNotFav = await favoriteService.isFavorite(favoriteRestaurant.id);
      expect(isNotFav, isFalse);
    });
  });
}
