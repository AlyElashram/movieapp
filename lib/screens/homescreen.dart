import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/movieController.dart';
import 'package:movieapp/screens/favourites.dart';
import 'package:movieapp/widgets/movie_list_tile.dart';

import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieController controller = Get.put(MovieController());
  int _selectedindex = 0;
  @override
  void initState() {
    controller.getMovies();
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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Movies",
                      style: TextStyle(
                          fontFamily: 'Circular',
                          color: Color(0xFF2C3F58),
                          fontSize: 28),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: width - 20,
                height: height - 20,
                child: GetBuilder<MovieController>(builder: (_) {
                  List<Movie> movies = _.movies;
                  return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Card(
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
                            child: movieListTile(width, height, movies[index]));
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
