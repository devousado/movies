import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/movie_model.dart';
import '../ui/movie_description_page.dart';
import '../ui/util/carousel.dart';
import '../ui/util/style.dart';

Widget wigetCarroselComponent(
    BuildContext context, List<MovieModel> movieListModel, int durationTime) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.40,
    child: Carossel(
      durationTime: durationTime,
      length: movieListModel.length,
      itemBuilder: (p0, index, p2) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Hero(
                    tag: 'hero-rectangle',
                    child: MovieDetailPage(
                      movieId: movieListModel[index].id,
                    ),
                  );
                }),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: 160,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${movieListModel[index].backdroppath}",
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    movieListModel[index].releasedate,
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
                        movieListModel[index].voteaverage.toString(),
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
                movieListModel[index].originaltitle,
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
      aspectRatio: 1.0,
      viewportFraction: 0.5,
    ),
  );
}
