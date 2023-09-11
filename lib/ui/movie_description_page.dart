import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/model/cast_model.dart';
import 'package:movies/state/movie_state.dart';
import 'package:movies/ui/util/error_text.dart';
import 'package:movies/ui/util/rating_bar.dart';

import 'package:movies/ui/util/shimmer_movie_description.dart';
import 'package:movies/ui/util/shimmer_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/movie_detail_model.dart';

// ignore: must_be_immutable
class MovieDetailPage extends ConsumerWidget {
  MovieDetailPage({super.key, required this.movieId});
  int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<CastModel>> castList = ref.watch(castState(movieId));
    AsyncValue<MovieDetailModel> detail = ref.watch(detailState(movieId));
    AsyncValue<String> video = ref.watch(videoState(movieId));

    if (castList is AsyncLoading || detail is AsyncLoading) {
      return const CustomShimmer2();
    } else if (castList is AsyncData && detail is AsyncData) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${detail.value!.backdroppath}",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.003,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                    label: Text(""),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.17,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: GestureDetector(
                    onTap: () async {
                      final youtUrl =
                          "http://www.youtube.com/watch?v=${video.value!}";
                      await launchUrl(Uri.parse(youtUrl),
                          mode: LaunchMode.inAppWebView);
                    },
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.red,
                      size: 70,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  detail.value!.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _customText(
                            color: Colors.grey,
                            text: detail.value!.releasedate,
                            horizontal: 10),
                        _customText(
                            color: Colors.grey,
                            text: detail.value!.genre,
                            horizontal: 10),
                        _customText(
                            color: Colors.grey,
                            text: "- ${detail.value!.runtime}m",
                            horizontal: 10)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomRatingBar(
                  numberOfRating: detail.value!.voteaverage,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _customText(
                text: "Historia",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                horizontal: 20,
                vertical: 5),
            _customText(
                text: detail.value!.overview,
                color: Colors.grey,
                fontSize: 15,
                horizontal: 20,
                vertical: 5),
            const SizedBox(
              height: 20,
            ),
            _customText(
                text: "Elencos e Produção",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                horizontal: 20,
                vertical: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                shrinkWrap: true,
                itemCount: castList.value!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          castList.value![index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    progressIndicatorBuilder: (context, url, progress) =>
                        const CustoShimmer3(),
                    imageUrl: castList.value![index].profilepath == null
                        ? "https://th.bing.com/th/id/OIP.p36Pj094hHbcVQXWZbu5vQAAAA?pid=ImgDet&rs=1"
                        : "https://image.tmdb.org/t/p/w500${castList.value![index].profilepath}",
                    fit: BoxFit.cover,
                  );
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: ErroScreen(error: "Falha ao carregar os dados"),
      );
    }
  }
}

Widget _customText(
    {required String text,
    FontWeight? fontWeight,
    double? fontSize,
    required Color color,
    double? horizontal,
    double? vertical}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0.0, vertical: vertical ?? 0.0),
    child: Text(
      text,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    ),
  );
}
