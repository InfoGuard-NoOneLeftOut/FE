import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List<String> imagePaths;

  const Carousel({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 16 / 9,
          initialPage: 0,
        ),
        items: imagePaths.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
