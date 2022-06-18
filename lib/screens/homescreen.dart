import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/movieController.dart';
import 'package:movieapp/widgets/movie_list_tile.dart';

import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieController controller = Get.put(MovieController());
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
      backgroundColor: Color(0xFFFAFBFD),
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
                        return movieListTile(width, height, movies[index]);
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
