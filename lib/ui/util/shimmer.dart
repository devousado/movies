import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../carousel.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView(
          shrinkWrap: true,
          children: [
            Carossel(
              length: 5,
              movies: [],
              aspectRatio: 2.1,
              viewportFraction: 0.8,
              itemBuilder: (p0, p1, p2) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 200,
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 15,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 290,
              child: Carossel(
                length: 5,
                movies: [],
                aspectRatio: 1.0,
                viewportFraction: 0.5,
                itemBuilder: (p0, p1, p2) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 200,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CircleAvatar(
                      radius: 70,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
