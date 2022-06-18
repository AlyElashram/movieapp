import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/screens/favourites.dart';
import 'package:movieapp/screens/homescreen.dart';
import 'package:movieapp/screens/single_movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  int _selectedindex = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeScreen()),
    );
  }
}
