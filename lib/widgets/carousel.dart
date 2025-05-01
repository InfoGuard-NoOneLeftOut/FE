import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List<String> imageUrls = [
    'https://via.placeholder.com/400x200.png?text=Slide+1',
    'https://via.placeholder.com/400x200.png?text=Slide+2',
    'https://via.placeholder.com/400x200.png?text=Slide+3',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 16 / 9,
          initialPage: 0,
        ),
        items: imageUrls.map((url) {
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
