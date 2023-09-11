import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer2 extends StatefulWidget {
  const CustomShimmer2({super.key});

  @override
  State<CustomShimmer2> createState() => _CustomShimmer2State();
}

class _CustomShimmer2State extends State<CustomShimmer2> {
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
            Container(
              color: Colors.grey,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.grey,
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.20,
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
