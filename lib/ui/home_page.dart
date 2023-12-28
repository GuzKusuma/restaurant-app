import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/restaurant_search.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Restaurant App',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final jsonData = await DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json');
              final List<Restaurant> restaurants = parseRestaurant(jsonData);

              setState(() {
                showSearch(
                  context: context,
                  delegate: RestaurantSearch(restaurants),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String? jsonData = snapshot.data;
            if (jsonData != null) {
              final List<Restaurant> restaurants = parseRestaurant(jsonData);
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                },
              );
            } else {
              return const Center(child: Text('Error: Empty Data'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error Loading Data: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
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
          )
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
