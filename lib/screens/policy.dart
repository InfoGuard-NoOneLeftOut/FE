import 'package:flutter/material.dart';

import 'package:infogaurd_fe/widgets/lists/recommendation_policy_list.dart';
import 'package:infogaurd_fe/widgets/cards/personalization_consent_card.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

class PolicyScreen extends StatelessWidget { // 맞춤 정책 페이지
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              MainLogoHeader(),
              PersonalizationConsentCard(), // 사용자 정보 수집 동의 카드
              RecommendationPolicySection(  policies: [ // 사용자 맞춤형 추천 정책
                WelfarePolicy(id: '1', title: '장애인 고용 지원', description: '고용 창출을 위한 다양한 혜택 제공', provider: '고용노동부'),
                WelfarePolicy(id: '2', title: '장애인 교육 바우처', description: '교육비 일부 지원', provider: '교육부'),
                WelfarePolicy(id: '3', title: '이동 지원 서비스', description: '특별교통수단 제공', provider: '국토부'),
                WelfarePolicy(id: '4', title: '주거환경 개선', description: '보조금 및 개조 지원', provider: '국토부'),
                WelfarePolicy(id: '5', title: '의료비 지원', description: '의료비 일부 보조', provider: '보건복지부'),
                WelfarePolicy(id: '6', title: '장애인 문화 활동', description: '문화 공연 할인 등 혜택', provider: '문화체육관광부'),
                WelfarePolicy(id: '7', title: '돌봄 지원 서비스', description: '장애 아동 돌봄 제공', provider: '보건복지부'),
                WelfarePolicy(id: '8', title: '자립생활 지원', description: '독립적 생활 지원', provider: '보건복지부'),
                WelfarePolicy(id: '9', title: '차량 개조 지원', description: '운전 보조 기기 설치 지원', provider: '국토부'),
              ],),
              // 이번 달 추천 정택 (카테고리 구분)
            ],
          )
        )
      )
    );
  }
}