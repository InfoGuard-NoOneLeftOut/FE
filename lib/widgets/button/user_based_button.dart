import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_category.dart';

class UserBasedCategoriesButton extends StatelessWidget { // 장애 등급별 카테고리 버튼
  final List<UserCategory> categories;

  const UserBasedCategoriesButton({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2, // 2열 기준, 자동 줄바꿈
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1, // 정사각형
        padding: const EdgeInsets.all(16),
        children: categories.map((category) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, category.route);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              height: 120,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  category.icon,
                  const SizedBox(height: 12),
                  Text(
                    category.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}