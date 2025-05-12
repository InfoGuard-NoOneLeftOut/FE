import 'package:flutter/material.dart';

class AccessibilityTipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( // 화면 중앙에 배치
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          color: Colors.indigoAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('접근성 팁', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• 음성 안내 기능 켜기', style: TextStyle(color: Colors.white)),
                Text('• 큰 글씨 모드 사용', style: TextStyle(color: Colors.white)),
                Text('• 고대비 모드 활성화', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
