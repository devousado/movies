import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/model/actor_model.dart';
import 'package:movies/model/genre_model.dart';
import 'package:movies/model/movie_model.dart';

import 'package:movies/state/movie_state.dart';
import 'package:movies/ui/result_page.dart';
import 'package:movies/ui/util/search_bottom.dart';
import 'package:movies/ui/util/shimmer_home_page.dart';
import 'package:movies/ui/util/style.dart';

import '../component/slide_form_component.dart';
import 'util/carousel.dart';
import 'movie_description_page.dart';

class FilmPage extends ConsumerStatefulWidget {
  const FilmPage({super.key});

  @override
  ConsumerState<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends ConsumerState<FilmPage> {
  TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<MovieModel>> movieList = ref.watch(movieState);

    AsyncValue<List<MovieModel>> popularFilm = ref.watch(populaFilmState);
    AsyncValue<List<GenreModel>> genreList = ref.watch(genreState);
    AsyncValue<List<ActorModel>> listOfActor = ref.watch(actorState);
    AsyncValue<List<MovieModel>> movieListThaArePlayngNow =
        ref.watch(moviePlayngNowState);
    if (popularFilm.isRefreshing ||
        genreList.isRefreshing ||
        listOfActor.isRefreshing ||
        movieListThaArePlayngNow.isRefreshing) return CustomShimmer();
    if (movieList is AsyncLoading ||
        popularFilm is AsyncLoading ||
        genreList is AsyncLoading ||
        listOfActor is AsyncLoading ||
        movieListThaArePlayngNow is AsyncLoading) {
      return const CustomShimmer();
    } else if (movieList is AsyncData &&
        popularFilm is AsyncData &&
        genreList is AsyncData &&
        listOfActor is AsyncData &&
        movieListThaArePlayngNow is AsyncData) {
      return ListView(
        shrinkWrap: true,
        children: [
          searcWidget(
            textEditingController: controllerSearch,
            onSubmitted: (value) {
              if (value.isEmpty) return;
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return ResultPage(
                    providerState: searchState(value),
                  );
                }),
              );
              controllerSearch.clear();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _customText("Brevemente"),
          Carossel(
            durationTime: 10,
            length: movieList.value!.length,
            itemBuilder: (context, index, currentIndex) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return Hero(
                      tag: 'hero-rectangle',
                      child: MovieDetailPage(
                        movieId: movieList.value![index].id,
                      ),
                    );
                  }),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${movieList.value![index].backdroppath}",
                        imageBuilder: (context, imageProvider) {
                          return Image(image: imageProvider);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: 6,
                      child: Text(
                        movieList.value![index].title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            },
            aspectRatio: 2.1,
            viewportFraction: 0.8,
          ),
          SizedBox(
            height: 30,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: genreList.value!.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1a1b23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ResultPage(
                          providerState:
                              movieByGenreState(genreList.value![index].id));
                    }));
                  },
                  child: Text(
                    genreList.value![index].genre,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          _customText("Apresentando agora"),
          wigetCarroselComponent(context, movieListThaArePlayngNow.value!, 5),
          const SizedBox(
            height: 25,
          ),
          _customText("Populares"),
          wigetCarroselComponent(context, popularFilm.value!, 7),
          _customText("Actores da semana"),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      width: 18,
                    ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listOfActor.value!.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${listOfActor.value![index].image}",
                    imageBuilder: (context, imageProvider) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                          ),
                          Text(
                            listOfActor.value![index].name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      );
                    },
                  );
                }),
          )
        ],
      );
    } else {
      return Center(
        child: InkWell(
          onTap: () async {
            ref.invalidate(populaFilmState);
            ref.invalidate(genreState);
            ref.invalidate(moviePlayngNowState);
            ref.invalidate(actorState);
            ref.invalidate(movieState);
          },
          child: Text(
            "Erro ao carregar os Dados",
            style: style,
          ),
        ),
      );
    }
  }

  Widget _customText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
