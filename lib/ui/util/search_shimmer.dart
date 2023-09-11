import 'package:flutter/material.dart';
import 'package:movies/ui/util/rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class SearchSimmer extends StatelessWidget {
  const SearchSimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: 10,
            itemBuilder: (context, index) => Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.grey,
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRatingBar(numberOfRating: 5)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
