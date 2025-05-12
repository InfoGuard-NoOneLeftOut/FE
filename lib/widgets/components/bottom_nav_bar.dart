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
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95), // 살짝 투명한 흰색
        border: const Border(
          top: BorderSide(color: Colors.black12, width: 0.5), // 얇은 상단 경계선
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -1), // 위로 약간의 그림자
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        iconSize: 45,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.policy), label: '정책'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: '상담'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: '사용자'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: '더보기'),
        ],
      ),
    );
  }
}
