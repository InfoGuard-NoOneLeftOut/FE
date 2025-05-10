import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';
import 'package:infogaurd_fe/widgets/cards/user_profile_card.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

class UserScreen extends StatelessWidget { // 사용자 페이지
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 유저 데이터 생성 ＝＞ 변경 예정
    final user = UserProfile(
      name: '홍길동',
      age: 28,
      gender: Gender.male,
      region: '서울특별시 강남구',
      disabilityLevel: DisabilityLevel.severe,
      disabilityTypes: [DisabilityType.physical, DisabilityType.visual],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              MainLogoHeader(),
              UserProfileCard( // 사용자 프로필 표시
                userProfile: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}