import 'package:flutter/material.dart';

class ColorBlindFilterSelector extends StatefulWidget {
  const ColorBlindFilterSelector({Key? key}) : super(key: key);

  @override
  State<ColorBlindFilterSelector> createState() => _ColorBlindFilterSelectorState();
}

class _ColorBlindFilterSelectorState extends State<ColorBlindFilterSelector> {
  String _selectedFilter = '적록(적색약, 제1색맹) - 빨간색이 회색빛, 어둡게 보임';

  final List<String> _filters = [
    '적록(적색약, 제1색맹) - 빨간색이 회색빛, 어둡게 보임',
    '적록(녹색약, 제2색맹) - 빨강/녹색 구별이 어려움, 노란빛 도는 왜곡',
    '청황(제3색맹) - 파랑/노랑 구별이 어려움, 회색/보라빛처럼 보일 수 있음',
  ];

  Widget _buildColorChart(String filter) {
    // 필터별 예시 컬러 차트 정의
    List<Color> colors;

    switch (filter) {
      case '적록(적색약, 제1색맹) - 빨간색이 회색빛, 어둡게 보임':
        colors = [
          Colors.red.shade700,      // 빨강 (약하게 보임)
          Colors.green,             // 녹색
          Colors.brown,             // 갈색 (혼동 가능)
          Colors.orange.shade400,   // 주황 (빨강과 혼동)
          Colors.blue.shade800,     // 파랑 (정상 인식)
        ];
        break;
      case '적록(녹색약, 제2색맹) - 빨강/녹색 구별이 어려움, 노란빛 도는 왜곡':
        colors = [
          Colors.red.shade400,      // 빨강 (약간 회색빛)
          Colors.lime.shade600,     // 라임색 (녹색 왜곡)
          Colors.orange,            // 주황 (빨강과 혼동)
          Colors.yellow,            // 노랑 (강조됨)
          Colors.blue,              // 파랑 (정상 인식)
        ];
        break;
      case '청황(제3색맹) - 파랑/노랑 구별이 어려움, 회색/보라빛처럼 보일 수 있음':
        colors = [
          Colors.blue.shade600,     // 파랑 (약하게 보임)
          Colors.yellow.shade400,   // 노랑 (연하게 보임)
          Colors.cyan.shade700,     // 시안 (파랑 대체)
          Colors.grey.shade500,     // 노랑 왜곡 이미지
          Colors.pink.shade300,     // 보라/분홍 (혼동)
        ];
        break;
      default:
        colors = [Colors.grey, Colors.grey, Colors.grey];
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '색상 차트 미리 보기',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: colors.map((color) {
              return Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            '색맹 필터',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '9가지 색상표의 색을 더 쉽게 구별할 수 있도록 색맹 필터를 적용하세요.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ..._filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                onTap: () => setState(() => _selectedFilter = filter),
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Radio<String>(
                      value: filter,
                      groupValue: _selectedFilter,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) => setState(() => _selectedFilter = val!),
                    ),
                    Expanded(
                      child: Text(
                        filter,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          _buildColorChart(_selectedFilter),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                print('$_selectedFilter 필터가 적용되었습니다');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('적용'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}