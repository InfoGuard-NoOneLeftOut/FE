import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/easy_words.dart';

// 가상의 정책 모델 => 변경 예정
class WelfarePolicy {
  final String id;
  final String title;
  final String description;
  final String provider;

  WelfarePolicy({
    required this.id,
    required this.title,
    required this.description,
    required this.provider,
  });
}

class EasyWordsCard extends StatefulWidget {
  final List<WelfarePolicy> policies;

  const EasyWordsCard({Key? key, required this.policies}) : super(key: key);

  @override
  State<EasyWordsCard> createState() => _EasyWordsCardState();
}

class _EasyWordsCardState extends State<EasyWordsCard> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final displayedPolicies = _showAll ? widget.policies : widget.policies.take(
        5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '쉬운 용어 사전',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAll = !_showAll;
                  });
                },
                child: Text(_showAll ? '간략히 보기' : '더보기'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 리스트 뷰
        _showAll
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            itemCount: displayedPolicies.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              return _buildPolicyCard(displayedPolicies[index]);
            },
          ),
        )
            : SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: displayedPolicies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 160,
                child: _buildPolicyCard(displayedPolicies[index]),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

      ],
    );
  }

  // 카드 위젯
  Widget _buildPolicyCard(WelfarePolicy policy) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              policy.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              policy.description,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              policy.provider,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}