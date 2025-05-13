import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/easy_words.dart';

// 가상의 정책 모델 => 변경 예정
class WelfarePolicy {
  final String id;
  final String title;
  final String description;
  final String category;
  final Icon icon;

  WelfarePolicy({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
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
    final displayedPolicies = _showAll ? widget.policies : widget.policies.take(5).toList();

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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_showAll ? '간략히 보기' : '더보기'),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _showAll
            ? SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.primaries[policy.title.hashCode % Colors.primaries.length].shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 카테고리 태그
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              policy.category,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),

          // 아이콘 또는 이미지
          Center(
            child: policy.icon,
          ),
          const SizedBox(height: 16),

          // 제목
          Text(
            policy.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // 설명
          Text(
            policy.description,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
