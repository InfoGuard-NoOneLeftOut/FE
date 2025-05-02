import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/carousel.dart';
import 'package:infogaurd_fe/widgets/cards/custom_card.dart';
import 'package:infogaurd_fe/widgets/buttons/user_based_button.dart';
import 'package:infogaurd_fe/models/user_category.dart';

class HomeScreen extends StatelessWidget { // 메인 페이지
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                CustomCard( // 마감 임박 정책 안내 카드
                  height: 60,
                  child: Text(
                    '마감 임박 정책 안내',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Carousel( //인기 정책 안내 캐러셀
                  imagePaths: [
                    'assets/images/policy1.png',
                    'assets/images/policy2.png',
                    'assets/images/policy3.png',
                  ],
                ),
                UserBasedCategoriesButton(categories: userCategories),
              ],
            )
        )
      )
    );
  }
}

List<UserCategory> userCategories = [
  UserCategory(
    title: '중증',
    icon: const Icon(Icons.local_hospital, color: Colors.orange, size: 32),
    route: '/', // 해당 카테고리 선택 시 이동 경로
  ),
  UserCategory(
    title: '경증',
    icon: const Icon(Icons.local_hospital_outlined, color: Colors.blue, size: 32),
    route: '/',
  ),
];