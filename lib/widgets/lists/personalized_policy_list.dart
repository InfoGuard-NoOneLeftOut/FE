import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/welfare_policy.dart';
import 'recommendation_policy_list.dart';

class PersonalizedPolicyList extends StatelessWidget {
  final String selectedCategory;
  final List<String> policyCategories;
  final List<WelfarePolicy> policies;
  final void Function(String) onCategoryChanged;

  const PersonalizedPolicyList({
    Key? key,
    required this.selectedCategory,
    required this.policyCategories,
    required this.policies,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '홍길동님을 위한 맞춤 정책',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: policyCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = policyCategories[index];
              final isSelected = category == selectedCategory;

              return GestureDetector(
                onTap: () => onCategoryChanged(category),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: RecommendationPolicySection(policies: policies),
        ),
      ],
    );
  }
}
