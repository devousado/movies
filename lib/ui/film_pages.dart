import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/model/actor_model.dart';
import 'package:movies/model/genre_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/state/movie_state.dart';
import 'package:movies/ui/util/shimmer.dart';
import 'package:movies/ui/util/style.dart';

import 'carousel.dart';

class FilmPage extends ConsumerStatefulWidget {
  const FilmPage({super.key});

  @override
  ConsumerState<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends ConsumerState<FilmPage> {
  int currenIndexOfTypeOfMovie = 0;
  @override
  void initState() {
    ref.read(movieState);
    ref.read(populaFilmState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<MovieModel>> movieList = ref.watch(movieState);
    AsyncValue<List<MovieModel>> popularFilm = ref.watch(populaFilmState);
    AsyncValue<List<GenreModel>> genreList = ref.watch(genreState);
    AsyncValue<List<ActorModel>> listOfActor = ref.watch(actorState);
    if (movieList is AsyncLoading ||
        popularFilm is AsyncLoading ||
        genreList is AsyncLoading ||
        listOfActor is AsyncLoading) {
      return const CustomShimmer();
    } else if (movieList is AsyncData &&
        popularFilm is AsyncData &&
        genreList is AsyncData &&
        listOfActor is AsyncData) {
      return ListView(
        shrinkWrap: true,
        children: [
          _customText("Brevemente"),
          Carossel(
            length: movieList.value!.length,
            itemBuilder: (context, index, currentIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${movieList.value![index].backdroppath}",
                  imageBuilder: (context, imageProvider) {
                    return Image(image: imageProvider);
                  },
                ),
              );
            },
            movies: movieList.value!,
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
                    backgroundColor: currenIndexOfTypeOfMovie == index
                        ? Colors.red
                        : const Color(0xFF1a1b23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      currenIndexOfTypeOfMovie = index;
                    });
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
          _customText("Populares"),
          SizedBox(
            height: 290,
            child: Carossel(
              length: popularFilm.value!.length,
              itemBuilder: (p0, index, p2) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: 160,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500${popularFilm.value![index].backdroppath}",
                          imageBuilder: (context, imageProvider) {
                            return Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF1a1b23),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            popularFilm.value![index].popularity.toString(),
                            style: style,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1a1b23),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            popularFilm.value![index].releasedate,
                            style: style,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF1a1b23),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Text(
                                popularFilm.value![index].voteaverage
                                    .toString(),
                                style: style,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        popularFilm.value![index].originaltitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                );
              },
              movies: popularFilm.value!,
              aspectRatio: 1.0,
              viewportFraction: 0.5,
            ),
          ),
          _customText("Actores da semana"),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 80,
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
                          CircleAvatar(
                            backgroundImage: imageProvider,
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
      return Text(
        "Erro ao carregar os Dados",
        style: style,
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
