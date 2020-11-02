class Movie{
  String title;
  String rated;
  String year;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String award;
  String poster;
  String metascore;
  String imdbRatings;
  String imdbID;
  String imdbVotes;
  String Type;
  String Response;
  List<String> images;
  Movie(this.title, this.rated, this.year, this.released, this.runtime,
      this.genre, this.director, this.writer, this.actors, this.plot,
      this.language, this.country, this.award, this.poster, this.metascore,
      this.imdbRatings, this.imdbID, this.imdbVotes, this.Type, this.Response,
      this.images);

  Movie.fromJson(Map<String,dynamic> Jsonmap)
  : title = Jsonmap["Title"],
  rated = Jsonmap["Rated"],
  year = Jsonmap["Released"],
  runtime= Jsonmap["Runtime"],
  genre = Jsonmap["Genre"],
  director = Jsonmap["Director"],
  writer = Jsonmap["Writer"],
  actors= Jsonmap["Actors"],
  plot = Jsonmap ["Plot"],
  language =Jsonmap["Languages"],
  country = Jsonmap ["Country"],
  award = Jsonmap["Awards"],
  poster = Jsonmap["Poster"],
  metascore = Jsonmap["Metascore"],
  imdbRatings = Jsonmap["imdbRating"],
  imdbID = Jsonmap["imdbID"],
  Type = Jsonmap["Type"],
  Response = Jsonmap["Response"],
  imdbVotes = Jsonmap["imdbID"],
  images = Jsonmap ["Images"],
  released = Jsonmap ["Released"];


}