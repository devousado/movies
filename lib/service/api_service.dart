import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as https;
import 'package:movies/const/api_key.dart';
import 'package:movies/model/actor_model.dart';
import 'package:movies/model/cast_model.dart';
import 'package:movies/model/genre_model.dart';
import 'package:movies/model/movie_model.dart';

import '../model/movie_detail_model.dart';

class ApiService {
  ApiService(this.http);
  https.Client http;

  Future<List<MovieModel>> getListOfFilmThatAreComingUp() async {
    try {
      List<MovieModel> filmList = [];
      final response = await https.get(
          Uri.parse("$url/movie/upcoming?api_key=$apiKey&language=pt"),
          headers: headers);
      var jsonDecodeData = jsonDecode(response.body);
      for (var element in jsonDecodeData["results"]) {
        filmList.add(MovieModel.fromMap(element));
      }

      return filmList;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieModel>> getPopularFilm() async {
    List<MovieModel> listOfPopularFilm = [];
    try {
      final response = await http.get(
          Uri.parse(
            "$url/movie/now_playing?api_key=$apiKey&language=pt",
          ),
          headers: headers);
      var jsonDecodeData = jsonDecode(response.body);
      for (var element in jsonDecodeData["results"]) {
        listOfPopularFilm.add(MovieModel.fromMap(element));
      }

      return listOfPopularFilm;
    } catch (e) {
      return [];
    }
  }

  Future<List<GenreModel>> getListOfGenre() async {
    List<GenreModel> listGenre = [];
    try {
      final response = await https
          .get(Uri.parse("$url/genre/movie/list?api_key=$apiKey&language=pt"));
      var jsonDecodeData = jsonDecode(response.body);
      for (var element in jsonDecodeData["genres"]) {
        listGenre.add(GenreModel.fromMap(element));
      }

      return listGenre;
    } catch (e) {
      return [];
    }
  }

  Future<List<ActorModel>> getactorInTrending() async {
    List<ActorModel> listActor = [];
    try {
      final response = await https.get(
          Uri.parse("$url/trending/person/week?api_key=$apiKey&language=pt"),
          headers: headers);

      var jsonDecodeData = jsonDecode(response.body);
      for (var element in jsonDecodeData["results"]) {
        listActor.add(ActorModel.fromMap(element));
      }
      return listActor;
    } catch (e) {
      return [];
    }
  }

  Future<MovieDetailModel> detailMovie(int movieId) async {
    try {
      final response = await https
          .get(Uri.parse("$url/movie/$movieId?api_key=$apiKey&language=pt"));
      var jsonDecodeData = jsonDecode(response.body);

      return MovieDetailModel.fromMap(jsonDecodeData);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CastModel>> getListOfCast(int movieId) async {
    List<CastModel> listCast = [];
    try {
      final response = await https
          .get(Uri.parse("$url/movie/$movieId/credits?api_key=$apiKey"));

      var jsonDecodeData = jsonDecode(response.body);

      for (var element in jsonDecodeData["cast"]) {
        listCast.add(CastModel.fromMap(element));
      }

      return listCast;
    } catch (e) {
      throw Exception("erro:$e");
    }
  }

  Future<String> getVideoYoutId(int id) async {
    try {
      final response =
          await https.get(Uri.parse("$url/movie/$id/videos?api_key=$apiKey"));
      var jsonDecodeData = jsonDecode(response.body);
      return jsonDecodeData["results"][0]["key"];
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}

final providerFilm = Provider<ApiService>((ref) => ApiService(https.Client()));
