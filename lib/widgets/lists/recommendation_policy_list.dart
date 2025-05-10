import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/welfare_policy.dart';

class RecommendationPolicySection extends StatelessWidget {
  final List<WelfarePolicy> policies;
  const RecommendationPolicySection({Key? key, required this.policies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (policies.isEmpty) return Center(child: Text('해당 카테고리 정책이 없습니다.'));
    return ListView.separated(
      itemCount: policies.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final p = policies[i];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: Icon(Icons.policy, color: Colors.indigo),
            title: Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(p.description),
            trailing: Text(p.provider, style: TextStyle(fontSize: 12, color: Colors.black54)),
          ),
        );
      },
    );
  }
}