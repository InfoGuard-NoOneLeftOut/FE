import 'package:flutter/material.dart';

class HighContrastModeToggle extends StatefulWidget { // 고대비 모드
  const HighContrastModeToggle({Key? key}) : super(key: key);

  @override
  State<HighContrastModeToggle> createState() => _HighContrastModeToggleState();
}

class _HighContrastModeToggleState extends State<HighContrastModeToggle> {
  bool _isHighContrastEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '고대비 모드',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '고대비 모드는 화면 요소의 대비를 높여 시인성을 향상시킵니다. '
                '시각적인 구분이 어려운 사용자에게 적합합니다.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '고대비 모드 켜기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Switch.adaptive(
                value: _isHighContrastEnabled,
                activeColor: Colors.blueAccent,
                onChanged: (bool value) {
                  setState(() {
                    _isHighContrastEnabled = value;
                  });
                  // 필요 시 contrast mode 적용 로직 추가
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
