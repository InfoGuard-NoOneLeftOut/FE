import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_category.dart';

class UserBasedCategoriesButton extends StatelessWidget {
  final List<UserCategory> categories;

  const UserBasedCategoriesButton({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      childAspectRatio: 1, // 정사각형 셀
      children: categories.map((category) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, category.route);
          },
          child: Material(
            color: Colors.white,
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: const IconThemeData(size: 40),
                    child: category.icon,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
