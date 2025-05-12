import 'package:flutter/material.dart';

class AccessibilityTipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( // 화면 중앙에 배치
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Card(
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('접근성 팁', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('큰 글씨 모드 – 작은 글씨가 잘 보이도록 확대합니다', style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('색맹 필터 – 색상 구별을 돕습니다', style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('고대비 모드 – 화면 대비를 높여 가독성을 개선합니다', style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
