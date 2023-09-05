import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Carossel extends StatefulWidget {
  Carossel(
      {super.key,
      required this.container,
      required this.viewportFraction,
      required this.aspectRatio});
  Widget container;
  double viewportFraction;
  double aspectRatio;
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
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CarouselSlider.builder(
        carouselController: carouselController,
        itemCount: 6,
        itemBuilder: (context, index, realIndex) {
          return widget.container;
        },
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlay: false,
          aspectRatio: widget.aspectRatio,
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: widget.viewportFraction,
          enlargeCenterPage: true,
          pauseAutoPlayInFiniteScroll: true,
        ),
      ),
    );
  }
}
