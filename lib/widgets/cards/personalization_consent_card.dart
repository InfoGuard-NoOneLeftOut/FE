import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/forms/user_profile_form.dart';

class PersonalizationConsentCard extends StatelessWidget { // 맞춤 정책 정보 수집 요청 카드
  final double? width;

  const PersonalizationConsentCard({
    Key? key,
    this.width,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.8, // 전체 화면의 80%
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/icon2.png',
                  height: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  '맞춤 정책 설정을 통해\n더욱 적합한 정책을 확인해보세요!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  '나에게 꼭 맞는 정책을 찾아보세요.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton( // 해당 버튼 클릭 시 user_profile_form.dart 페이지로 이동
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfileForm(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '내 프로필 설정하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
