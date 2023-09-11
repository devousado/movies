import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/model/actor_model.dart';
import 'package:movies/model/cast_model.dart';
import 'package:movies/model/genre_model.dart';
import 'package:movies/model/movie_detail_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/service/api_service.dart';

final movieState = FutureProvider<List<MovieModel>>(
    (ref) => ref.read(providerFilm).getListOfFilmThatAreComingUp());
final populaFilmState = FutureProvider<List<MovieModel>>(
    (ref) => ref.read(providerFilm).getPopularFilm());
final genreState = FutureProvider<List<GenreModel>>(
    (ref) => ref.read(providerFilm).getListOfGenre());
final actorState = FutureProvider<List<ActorModel>>(
    (ref) => ref.read(providerFilm).getactorInTrending());
final castState = FutureProvider.family<List<CastModel>, int>(
    (ref, id) => ref.read(providerFilm).getListOfCast(id));
final detailState = FutureProvider.family<MovieDetailModel, int>(
    (ref, id) => ref.read(providerFilm).detailMovie(id));
final videoState = FutureProvider.family<String, int>(
    (ref, id) => ref.read(providerFilm).getVideoYoutId(id));
final searchState = FutureProvider.family<List<MovieModel>, String>(
    (ref, filmeName) => ref.read(providerFilm).searchMovie(filmeName));
final movieByGenreState = FutureProvider.family<List<MovieModel>, int>(
    (ref, genre) => ref.read(providerFilm).getMovieByGenre(genre));
final moviePlayngNowState = FutureProvider<List<MovieModel>>(
    (ref) => ref.read(providerFilm).getListOfFilmThatArePlayngNow());
