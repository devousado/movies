import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Carossel extends StatefulWidget {
  Carossel({
    super.key,
    required this.durationTime,
    required this.viewportFraction,
    required this.aspectRatio,
    required this.itemBuilder,
    required this.length,
  });
  int length;
  int durationTime;
  double viewportFraction;
  double aspectRatio;

  Widget Function(BuildContext, int, int)? itemBuilder;
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
        itemCount: widget.length,
        itemBuilder: widget.itemBuilder,
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlay: true,
          aspectRatio: widget.aspectRatio,
          autoPlayInterval: Duration(seconds: widget.durationTime),
          viewportFraction: widget.viewportFraction,
          enlargeCenterPage: true,
          pauseAutoPlayInFiniteScroll: true,
        ),
      ),
    );
  }
}
