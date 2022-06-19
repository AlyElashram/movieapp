import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  List<Movie> movies = [];
  List<Movie> favourites = [];
  MovieController() {
    getMovies();
    getFavourites();
  }

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

  void getFavourites() {
    List<String> ids = [];
    final storage = GetStorage();
    dynamic intermediate = storage.read('favourites') ?? [];
    intermediate.forEach((element) => {ids.add(element.toString())});
    List<Movie> favs =
        movies.where((element) => ids.contains(element.id)).toList();
    favourites = favs;
    update();
  }

  void addFavourite(String id) async {
    final storage = GetStorage();
    List<String> ids = [];
    dynamic intermediate = storage.read('favourites') ?? [];
    intermediate.forEach((element) => {ids.add(element.toString())});
    ids.add(id);
    await storage.write('favourites', ids);
    getFavourites();
  }

  void removeFavourite(String id) async {
    final storage = GetStorage();
    List<String> ids = [];
    dynamic intermediate = storage.read('favourites') ?? [];
    intermediate.forEach((element) => {ids.add(element.toString())});
    ids.remove(id);
    storage.remove('favourites');
    storage.write('favourites', ids);
    getFavourites();
  }

  bool isFavourite(String id) {
    for (Movie movie in favourites) {
      if (movie.id == id) {
        return true;
      }
    }
    return false;
  }
}
