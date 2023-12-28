import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/home_page.dart';

import 'package:restaurant_app/ui/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: secondaryColor,
        ),
        textTheme: myTextTheme,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}
