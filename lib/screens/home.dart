import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/components/carousel.dart';
import 'package:infogaurd_fe/widgets/cards/custom_card.dart';
import 'package:infogaurd_fe/widgets/buttons/user_based_button.dart';
import 'package:infogaurd_fe/models/user_category.dart';
import 'package:infogaurd_fe/widgets/cards/easy_words_card.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

// flutter pub global activate devtools
// flutter pub global run devtools

class HomeScreen extends StatelessWidget { // 메인 페이지
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20), //좌, 상, 우, 하
            child: Column(
              children: [
                MainLogoHeader(),
                CustomCard(
                  height: 80,
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
                              '2025년 장애인복지일자리사업',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '참여자 모집기간이 얼마 남지 않았어요!',
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

                EasyWordsCard( // 쉬운 용어 사전
                  policies: [
                    WelfarePolicy(
                      id: '1',
                      title: '장애인 고용 지원',
                      description: '고용 창출을 위한 다양한 혜택 제공',
                      category: '일자리',
                      icon: const Icon(Icons.work, size: 40, color: Colors.blue),
                    ),
                    WelfarePolicy(
                      id: '2',
                      title: '장애인 교육 바우처',
                      description: '교육비 일부 지원',
                      category: '교육',
                      icon: const Icon(Icons.school, size: 40, color: Colors.green),
                    ),
                    WelfarePolicy(
                      id: '3',
                      title: '이동 지원 서비스',
                      description: '특별교통수단 제공',
                      category: '교통',
                      icon: const Icon(Icons.directions_bus, size: 40, color: Colors.orange),
                    ),
                    WelfarePolicy(
                      id: '4',
                      title: '주거환경 개선',
                      description: '보조금 및 개조 지원',
                      category: '주거',
                      icon: const Icon(Icons.home_repair_service, size: 40, color: Colors.blue),
                    ),
                    // ...이하 생략
                  ],
                ),

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
    icon: const Icon(Icons.health_and_safety, color: Colors.blue),
    route: '/',
  ),
  UserCategory(
    title: '경증',
    icon: const Icon(Icons.medical_services, color: Colors.blue),
    route: '/',
  ),
  UserCategory(
    title: '문화 지원',
    icon: const Icon(Icons.theaters, color: Colors.blue),
    route: '/',
  ),
  UserCategory(
    title: '생활 지원',
    icon: const Icon(Icons.volunteer_activism, color: Colors.blue),
    route: '/',
  ),
];
