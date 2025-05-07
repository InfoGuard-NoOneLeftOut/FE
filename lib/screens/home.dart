import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/carousel.dart';
import 'package:infogaurd_fe/widgets/cards/custom_card.dart';
import 'package:infogaurd_fe/widgets/buttons/user_based_button.dart';
import 'package:infogaurd_fe/models/user_category.dart';

// flutter pub global activate devtools
// flutter pub global run devtools

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
                CustomCard(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/icon1.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '👩‍🦽 장애인복지일자리사업',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '마감 임박! 지금 신청하세요.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.chevron_right),
                    ],
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
  UserCategory(
    title: '문화 지원',
    icon: const Icon(Icons.movie_outlined, color: Colors.orange, size: 32),
    route: '/',
  ),
  UserCategory(
    title: '생활 지원',
    icon: const Icon(Icons.real_estate_agent_outlined, color: Colors.blue, size: 32),
    route: '/',
  ),
];