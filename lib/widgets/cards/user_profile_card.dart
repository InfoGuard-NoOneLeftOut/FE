import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;
  final bool showDetail; // 상세정보 표시 여부 (기본값 false)

  const UserProfileCard({
    Key? key,
    required this.userProfile,
    this.showDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfile.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            /// 기본 정보 그리드 UserProfileCard(userProfile: user)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              childAspectRatio: 3.5,
              children: [
                _buildInfoTile('나이', '${userProfile.age}세'),
                _buildInfoTile('성별', userProfile.gender == Gender.male ? '남성' : '여성'),
                _buildInfoTile('지역', userProfile.region),
                _buildInfoTile(
                  '장애 등급',
                  userProfile.disabilityLevel == DisabilityLevel.severe ? '중증' : '경증',
                ),
                _buildInfoTile(
                  '장애 유형',
                  userProfile.disabilityTypes.map(_getDisabilityTypeName).join(', '),
                ),
              ],
            ),

            /// 상세 정보 조건부 표시 UserProfileCard(userProfile: user, showDetail: true)
            if (showDetail) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              _buildInfoTile('장애 등록 여부', userProfile.isRegisteredDisabled == true ? '등록됨' : '미등록'),
              _buildInfoTile('복지카드 여부', userProfile.hasDisabilityCard == true ? '보유' : '미보유'),
              _buildInfoTile('소득 수준', userProfile.incomeLevel ?? '공란'),
              _buildInfoTile('가구 형태', userProfile.householdType ?? '공란'),
              _buildInfoTile('관심 정책 분야', userProfile.interestPolicyAreas?.join(', ') ?? '공란'),
              if (userProfile.guardianInfo != null)
                _buildInfoTile('보호자 정보', userProfile.guardianInfo!),
            ],
          ],
        ),
      ),
    );
  }

  /// 한 칸짜리 정보 타일 위젯
  Widget _buildInfoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  String _getDisabilityTypeName(DisabilityType type) {
    switch (type) {
      case DisabilityType.physical:
        return '지체';
      case DisabilityType.brainLesion:
        return '뇌병변';
      case DisabilityType.visual:
        return '시각';
      case DisabilityType.hearing:
        return '청각';
      case DisabilityType.mental:
        return '정신';
      case DisabilityType.autism:
        return '자폐';
      case DisabilityType.speech:
        return '언어';
    }
  }
}
