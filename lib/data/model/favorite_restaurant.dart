class FavoriteRestaurant {
  final String id;
  final String name;
  final String city;
  final String address;
  final String pictureId;
  final double rating;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
  });

  factory FavoriteRestaurant.fromMap(Map<String, dynamic> map) {
    return FavoriteRestaurant(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      address: map['address'],
      pictureId: map['pictureId'],
      rating: map['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'rating': rating,
    };
  }
}
