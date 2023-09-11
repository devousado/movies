import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/model/movie_model.dart';

import 'package:movies/ui/util/error_text.dart';
import 'package:movies/ui/util/rating_bar.dart';
import 'package:movies/ui/util/search_shimmer.dart';

import 'movie_description_page.dart';

// ignore: must_be_immutable
class ResultPage extends ConsumerWidget {
  ResultPage({super.key, required this.providerState});

  ProviderListenable<AsyncValue<List<MovieModel>>> providerState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MovieModel>> searchResult = ref.watch(providerState);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: searchResult.when(
            data: (data) {
              return data.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Hero(
                                tag: 'hero-rectangle',
                                child: MovieDetailPage(
                                  movieId: data[index].id,
                                ),
                              );
                            }),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageUrl: data[index].backdroppath == null
                                          ? "https://th.bing.com/th/id/OIP.p36Pj094hHbcVQXWZbu5vQAAAA?pid=ImgDet&rs=1"
                                          : "https://image.tmdb.org/t/p/w500${data[index].backdroppath}"),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      data[index].title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomRatingBar(
                                        numberOfRating: double.parse(
                                            data[index].voteaverage.toString()))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : ErroScreen(error: "Nao encontrados filmes correspondentes");
            },
            error: (error, stackTrace) {
              return ErroScreen(error: "Falha ao carregar os dados");
            },
            loading: () => const SearchSimmer()));
  }
}
