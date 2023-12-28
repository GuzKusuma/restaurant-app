import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantSearch extends SearchDelegate<String> {
  final List<Restaurant> restaurants;

  RestaurantSearch(this.restaurants);

  @override
  String get searchFieldLabel => 'Search a Restaurant...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = restaurants
        .where((restaurant) =>
            restaurant.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(context, result);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = restaurants
        .where((restaurant) =>
            restaurant.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(context, suggestionList);
  }

  Widget _buildSearchResults(BuildContext context, List<Restaurant> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildRestaurantItem(context, results[index]);
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(
        restaurant.name,
        style: myTextTheme.headlineSmall,
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.grey,
                size: 18,
              ),
              Text(
                restaurant.city,
                style: myTextTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 15,
                color: Colors.grey,
              ),
              Text(restaurant.rating.toString())
            ],
          ),
        ],
      ),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
