import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'homescreen.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int _selectedindex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: ((value) {
          if (value == 0 && _selectedindex != 0) {
            _selectedindex = value;
            Get.off(() => HomeScreen());
          }
          if (value == 1 && _selectedindex != 1) {
            _selectedindex = value;
            Get.off(() => FavouritesScreen());
          }
        }),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/movies.png'), label: 'Movies'),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favourites.png'),
            label: 'Favourites',
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Favourites",
              style: TextStyle(fontFamily: 'Circular', fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
