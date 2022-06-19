import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  List<Movie> movies = [];
  List<Movie> favourites = [];
  List<Movie> filtered = [];
  Set<String> genres = Set();
  MovieController() {
    getMoviesAndGenres();
    getFavourites();
  }

  getMoviesAndGenres() async {
    List<Movie> list = [];
    Set<String> genre = Set();
    const String url = "https://wookie.codesubmit.io/movies";
    http.Response res = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer Wookie2019"});
    if (res.statusCode == 200) {
      final Map<String, dynamic> response = jsonDecode(res.body);
      List responseMovies = response['movies'];
      responseMovies.forEach((element) {
        Movie item = Movie.fromJson(element);
        list.add(item);
        item.genres!.forEach((element) {
          genre.add(element.toString());
        });
      });
      movies = list;
      genres = genre;
      update();
    } else {
      throw ('Could not fetch movies error code:${res.statusCode}');
    }
  }

  void getFilteredMovies(String genre) {
    List<Movie> filter = [];
    for (Movie movie in movies) {
      if (movie.genres!.contains(genre)) {
        filter.add(movie);
      }
    }
    filtered = filter;
    update();
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
