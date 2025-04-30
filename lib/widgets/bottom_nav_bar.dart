import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: Colors.black,         // 선택된 아이콘 색
      unselectedItemColor: Colors.grey,        // 선택되지 않은 아이콘 색
      type: BottomNavigationBarType.fixed,     // 아이템 4개 이상이면 fixed 추천
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.policy), label: '맞춤정책'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '상담'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '사용자'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
      ],
    );
  }
}
