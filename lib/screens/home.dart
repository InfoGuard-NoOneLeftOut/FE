import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/carousel.dart';
import 'package:infogaurd_fe/widgets/custom_card.dart';

class HomeScreen extends StatelessWidget { // 메인 페이지
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomCard(
                height: 60,
                child: Text(
                  '마감 임박 정책 안내',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Carousel(
              ),
            ],
          )
      )
    );
  }
}
