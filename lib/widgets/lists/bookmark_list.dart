import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelfarePolicy {
  final String title;
  final DateTime deadline;
  bool isBookmarked;

  WelfarePolicy({
    required this.title,
    required this.deadline,
    this.isBookmarked = false,
  });
}

class BookmarkList extends StatefulWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  final List<WelfarePolicy> _policies = [
    WelfarePolicy(title: '장애인 교통비 지원', deadline: DateTime(2025, 5, 20), isBookmarked: true),
    WelfarePolicy(title: '장애인 장학금 신청', deadline: DateTime(2025, 6, 1), isBookmarked: true),
    WelfarePolicy(title: '보조기기 무상 대여', deadline: DateTime(2025, 6, 15), isBookmarked: true),
    WelfarePolicy(title: '장애인 취업지원 상담', deadline: DateTime(2025, 7, 5), isBookmarked: true),
  ];

  String _dday(DateTime deadline) {
    final diff = deadline.difference(DateTime.now()).inDays;
    return diff >= 0 ? 'D-$diff' : '마감';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '북마크 목록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: _policies.length,
            itemBuilder: (context, index) {
              final policy = _policies[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            policy.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _dday(policy.deadline),
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          policy.isBookmarked = !policy.isBookmarked;
                        });
                      },
                      child: Icon(
                        policy.isBookmarked
                            ? CupertinoIcons.bookmark_solid
                            : CupertinoIcons.bookmark,
                        color: policy.isBookmarked
                            ? CupertinoColors.systemBlue
                            : CupertinoColors.inactiveGray,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}
