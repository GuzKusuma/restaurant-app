import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });
    return const Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.food_bank_rounded,
              size: 50,
              color: primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'RESTAURANT APP',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
