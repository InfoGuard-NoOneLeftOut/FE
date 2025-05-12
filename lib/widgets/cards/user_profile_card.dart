import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;

  const UserProfileCard({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 왼쪽 프로필 사진
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey.shade200,
              child: userProfile.imagePath != null
                  ? ClipOval(
                child: Image.asset(
                  userProfile.imagePath!,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              )
                  : Icon(Icons.person, size: 32, color: Colors.grey),
            ),
            const SizedBox(width: 16),

            // 오른쪽 정보들
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이름
                  Text(
                    userProfile.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 1번째 줄: 나이, 성별
                  Row(
                    children: [
                      _InfoTag(label: '나이', value: '${userProfile.age}세'),
                      const SizedBox(width: 8),
                      _InfoTag(
                        label: '성별',
                        value: userProfile.gender == Gender.male ? '남성' : '여성',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 2번째 줄: 지역, 장애 등급, 장애 유형
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoTag(label: '지역', value: userProfile.region),
                      _InfoTag(
                        label: '장애 등급',
                        value: userProfile.disabilityLevel == DisabilityLevel.severe ? '중증' : '경증',
                      ),
                      _InfoTag(
                        label: '장애 유형',
                        value: userProfile.disabilityTypes.map(_getDisabilityTypeName).join(', '),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

class _InfoTag extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTag({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }
}
