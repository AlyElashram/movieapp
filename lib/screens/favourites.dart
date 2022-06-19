import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:movieapp/screens/single_movie.dart';

import '../models/movie.dart';
import '../widgets/movie_list_tile.dart';
import 'homescreen.dart';
import '../controllers/movieController.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int _selectedindex = 1;
  MovieController controller = Get.put(MovieController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "My Favourites",
                      style: TextStyle(fontFamily: 'Circular', fontSize: 28),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 6,
                child: Center(
                  child: Container(
                      width: width,
                      height: height,
                      child: GetBuilder<MovieController>(builder: (_) {
                        return ListView.builder(
                            itemCount: _.favourites.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(() => MovieDetails(
                                        movie: _.favourites[index]));
                                  },
                                  child: Card(
                                      shape: Border(
                                          bottom: BorderSide(
                                        width: 0.5,
                                        color: Color(0xFFB1C4DC),
                                      )),
                                      color: Color(0xFFFAFBFD),
                                      shadowColor: null,
                                      surfaceTintColor: null,
                                      borderOnForeground: false,
                                      elevation: 0,
                                      child: movieListTile(
                                          width, height, _.favourites[index])));
                            });
                      })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
