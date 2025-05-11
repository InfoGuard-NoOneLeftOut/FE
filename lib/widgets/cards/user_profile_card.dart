import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;
  final bool showDetail;

  const UserProfileCard({
    Key? key,
    required this.userProfile,
    this.showDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = screenWidth / 2.3;

    return Card(
      elevation: 1,
      color: const Color(0xFFF9F9F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 기본 정보 카드
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 이름
                Center(
                  child: Text(
                    userProfile.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 1행: 2열
                Row(
                  children: [
                    Flexible(
                      child: _buildInfoTile(
                        '나이',
                        '${userProfile.age}세',
                        icon: Icons.cake,
                        iconColor: Colors.orange,
                        width: boxWidth,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: _buildInfoTile(
                        '성별',
                        userProfile.gender == Gender.male ? '남성' : '여성',
                        icon: Icons.person,
                        iconColor: Colors.blue,
                        width: boxWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2행: 3열
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildInfoTile(
                        '지역',
                        userProfile.region,
                        icon: Icons.location_on,
                        iconColor: Colors.green,
                        width: boxWidth,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoTile(
                        '장애 등급',
                        userProfile.disabilityLevel == DisabilityLevel.severe ? '중증' : '경증',
                        icon: Icons.grade,
                        iconColor: Colors.purple,
                        width: boxWidth,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoTile(
                        '장애 유형',
                        userProfile.disabilityTypes.map(_getDisabilityTypeName).join(', '),
                        icon: Icons.accessibility_new,
                        iconColor: Colors.teal,
                        width: boxWidth,
                      ),
                    ),
                  ],
                ),
              ],
            ),


            if (showDetail) ...[
              const SizedBox(height: 28),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildInfoTile(
                    '장애 등록 여부',
                    userProfile.isRegisteredDisabled == true ? '등록됨' : '미등록',
                    icon: Icons.verified,
                    iconColor: Colors.indigo,
                    width: boxWidth,
                  ),
                  _buildInfoTile(
                    '복지카드 여부',
                    userProfile.hasDisabilityCard == true ? '보유' : '미보유',
                    icon: Icons.credit_card,
                    iconColor: Colors.redAccent,
                    width: boxWidth,
                  ),
                  _buildInfoTile(
                    '소득 수준',
                    userProfile.incomeLevel ?? '공란',
                    icon: Icons.monetization_on,
                    iconColor: Colors.green,
                    width: boxWidth,
                  ),
                  _buildInfoTile(
                    '가구 형태',
                    userProfile.householdType ?? '공란',
                    icon: Icons.home,
                    iconColor: Colors.orange,
                    width: boxWidth,
                  ),
                  _buildInfoTile(
                    '관심 정책 분야',
                    userProfile.interestPolicyAreas?.join(', ') ?? '공란',
                    icon: Icons.policy,
                    iconColor: Colors.blueGrey,
                    width: boxWidth,
                  ),
                  if (userProfile.guardianInfo != null)
                    _buildInfoTile(
                      '보호자 정보',
                      userProfile.guardianInfo!,
                      icon: Icons.family_restroom,
                      iconColor: Colors.deepPurple,
                      width: boxWidth,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 정보 타일 위젯
  Widget _buildInfoTile(String title, String value,
      {required IconData icon, required Color iconColor, required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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
