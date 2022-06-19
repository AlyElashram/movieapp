import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controllers/movieController.dart';
import 'package:movieapp/screens/favourites.dart';
import 'package:movieapp/screens/single_movie.dart';
import 'package:movieapp/widgets/movie_list_tile.dart';

import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieController controller = Get.put(MovieController());
  bool isFilter = false;
  String genre = 'Genre';
  int _selectedindex = 0;
  bool hide = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
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
              child: hide
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFB1C4DC)))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Movies',
                              style: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: 14,
                                  color: Color(0xFF2C3F58)),
                            ),
                            SizedBox(height: 14)
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Movies",
                                style: TextStyle(
                                    fontFamily: 'Circular',
                                    color: Color(0xFF2C3F58),
                                    fontSize: 28),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 0,
                                      primary: Color(0xFFD7E1EA)),
                                  onPressed: () {
                                    _showActionSheet(context);
                                  },
                                  child: Text(genre,
                                      style: TextStyle(
                                          fontFamily: 'Circular',
                                          fontSize: 12,
                                          color: Color(0xFF4E5E71))))
                            ],
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
                  return NotificationListener(
                    onNotification: (notification) {
                      if (notification == ScrollUpdateNotification) {}
                      if (_scrollController.position.pixels > 105) {
                        setState(() {
                          hide = true;
                        });
                      } else {
                        setState(() {
                          hide = false;
                        });
                      }
                      return true;
                    },
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            isFilter ? _.filtered.length : _.movies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => MovieDetails(
                                  movie: isFilter
                                      ? _.filtered[index]
                                      : _.movies[index]));
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
                                    width,
                                    height,
                                    isFilter
                                        ? _.filtered[index]
                                        : _.movies[index])),
                          );
                        }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<CupertinoActionSheetAction> _createActions() {
    Set<String> genres = controller.genres;
    List<CupertinoActionSheetAction> actions = [];
    actions.add(CupertinoActionSheetAction(
      isDefaultAction: true,
      onPressed: () {
        controller.getMoviesAndGenres();
        setState(() {
          genre = 'Genre';
          isFilter = false;
          Get.back();
        });
      },
      child: Text(
        'No filter',
        style: TextStyle(
            fontFamily: 'Circular', fontSize: 17, color: Color(0xFF2C3F58)),
      ),
    ));
    genres.forEach((element) {
      actions.add(CupertinoActionSheetAction(
        onPressed: () {
          controller.getFilteredMovies(element);
          setState(() {
            genre = element;
            isFilter = true;
            Get.back();
          });
        },
        child: Text(element,
            style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 17,
                color: Color(0xFF2C3F58))),
      ));
    });
    return actions;
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Available Genres'),
        message: const Text('Choose a genre to filter by'),
        actions: _createActions(),
      ),
    );
  }
}
