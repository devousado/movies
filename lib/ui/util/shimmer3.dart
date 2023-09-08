import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustoShimmer3 extends StatelessWidget {
  const CustoShimmer3({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.20,
        ),
      ),
    );
  }
}
