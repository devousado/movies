import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carossel extends StatefulWidget {
  const Carossel({super.key});

  @override
  State<Carossel> createState() => _CarosselState();
}

class _CarosselState extends State<Carossel> {
  late CarouselController carouselController;

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  void dispose() {
    carouselController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: CarouselSlider.builder(
        carouselController: carouselController,
        itemCount: 6,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 100,
              color: Colors.amber,
            ),
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          pauseAutoPlayInFiniteScroll: true,
        ),
      ),
    );
  }
}
