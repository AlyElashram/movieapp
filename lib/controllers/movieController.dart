import 'dart:convert';
import 'package:get/get.dart';
import 'package:movieapp/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  List<Movie> movies = [];

  getMovies() async {
    List<Movie> list = [];
    const String url = "https://wookie.codesubmit.io/movies";
    http.Response res = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer Wookie2019"});
    if (res.statusCode == 200) {
      final Map<String, dynamic> response = jsonDecode(res.body);
      List responseMovies = response['movies'];
      responseMovies.forEach((element) {
        list.add(Movie.fromJson(element));
      });
      movies = list;
      update();
    } else {
      throw ('Could not fetch movies error code:${res.statusCode}');
    }
  }
}
