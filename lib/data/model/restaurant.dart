import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final List<String> menusFoods;
  final List<String> menusDrinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menusFoods,
    required this.menusDrinks,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) {
    return Restaurant(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: restaurant['rating'].toDouble(),
      menusFoods: (restaurant['menus']['foods'] as List<dynamic>? ?? [])
          .map<String>((item) => item['name'] as String)
          .toList(),
      menusDrinks: (restaurant['menus']['drinks'] as List<dynamic>? ?? {})
          .map<String>((item) => item['name'] as String)
          .toList(),
    );
  }
}

List<Restaurant> parseRestaurant(String json) {
  final List<dynamic> parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
