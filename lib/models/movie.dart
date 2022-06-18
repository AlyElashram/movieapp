class Movie {
  String? backdrop;
  List? cast;
  String? classification;
  List<String>? director;
  List? genres;
  String? id;
  double? imdb_rating;
  String? length;
  String? overview;
  String? poster;
  String? released_on;
  String? slug;
  String? title;

  Movie(
      this.backdrop,
      this.cast,
      this.classification,
      this.director,
      this.genres,
      this.id,
      this.imdb_rating,
      this.length,
      this.overview,
      this.poster,
      this.released_on,
      this.slug,
      this.title);

  factory Movie.fromJson(dynamic json) {
    //directors can be a List or a single String
    //check if it is a single string add it to a list
    List<String> director;
    try {
      director = json['director'] as List<String>;
    } catch (e) {
      director = [json['director'].toString()];
    }
    return Movie(
      json['backdrop'] as String,
      json['cast'] as List,
      json['classification'] as String,
      director,
      json['genres'] as List,
      json['id'] as String,
      json['imdb_rating'] as double,
      json['length'] as String,
      json['overview'] as String,
      json['poster'] as String,
      json['released_on'] as String,
      json['slug'] as String,
      json['title'] as String,
    );
  }
}
