import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/movie.dart';
import '../screens/single_movie.dart';

Widget movieListTile(double width, double height, Movie movie) {
  String genres = '';
  movie.genres?.forEach((genre) => {genres += genre + ' ' + '|' + ' '});
  genres = genres.substring(0, genres.length - 2);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      width: width / 8,
      height: height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  movie.poster!,
                  width: 66,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    genres,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 12,
                      color: Color(0xFF778699),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      movie.title!,
                      style: TextStyle(
                          fontFamily: 'Circular',
                          color: Color(0xFF2C3F58),
                          fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Color(0xFFD7E1EA),
              size: 22,
            ),
          ),
        ],
      ),
    ),
  );
}
