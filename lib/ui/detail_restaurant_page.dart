import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        children: [
                          const StarButtonState(),
                          Text('${restaurant.rating}'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      Text(restaurant.city)
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildScrollableRow("Foods", restaurant.menusFoods),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildScrollableRow("Drinks", restaurant.menusDrinks),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildScrollableRow(String tipe, List<String> items) {
  return Row(
    children: [
      Text(tipe),
      const SizedBox(width: 8),
      Expanded(
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Chip(label: Text(items[index])),
              );
            },
          ),
        ),
      ),
    ],
  );
}

class StarButtonState extends StatefulWidget {
  const StarButtonState({super.key});

  @override
  State<StarButtonState> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButtonState> {
  bool isStarState = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isStarState ? Icons.star_rate : Icons.star_rate_outlined,
          color: isStarState ? Colors.yellow : null),
      iconSize: 30,
      onPressed: () {
        setState(() {
          isStarState = !isStarState;
        });
      },
    );
  }
}
