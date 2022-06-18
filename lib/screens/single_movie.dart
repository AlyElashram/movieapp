import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../models/movie.dart';
import 'homescreen.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    DateTime release_date = DateTime.parse(widget.movie.released_on!);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                            splashColor: Colors.transparent,
                            elevation: 0,
                            backgroundColor: Color(0xFF333333).withOpacity(0.5),
                            child: Icon(Icons.close,
                                color: Colors.white, size: 22),
                            onPressed: () {
                              Get.off(() => HomeScreen());
                            }),
                      )
                    ],
                  ),
                ),
                Text(
                  widget.movie.title!,
                  style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 26,
                      color: Color(0xFF2C3F58)),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.movie.imdb_rating.toString() + ' Stars',
                      style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 14,
                          color: Color(0xFF2C3F58)),
                    )
                  ],
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.movie.backdrop!,
                    width: width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      widget.movie.length!,
                      style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 14,
                          color: Color(0xFF2C3F58)),
                    ),
                    Spacer(),
                    Text(
                      release_date.day.toString() +
                          '.' +
                          release_date.month.toString() +
                          '.' +
                          release_date.year.toString(),
                      style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 14,
                          color: Color(0xFF2C3F58)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(widget.movie.overview!,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Circular',
                      fontSize: 17,
                      color: Color(0xFF2C3F58),
                    )),
              ],
            ),
          ),
          Spacer(),
          Divider(thickness: 2, color: Color(0xFF25245F).withOpacity(0.2)),
          Container(
            width: width,
            height: 115,
            child: Center(
              child: Container(
                  width: width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(width: 0.7, color: Color(0xFF25245F))),
                    child: Text(
                      "Add to Favourites",
                      style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 16,
                          color: Color(0xFF2C3F58)),
                    ),
                    onPressed: () {
                      //TODO:Add To Favourites
                    },
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
