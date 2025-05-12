import 'package:flutter/material.dart';

class ColorBlindFilterSelector extends StatefulWidget {
  const ColorBlindFilterSelector({Key? key}) : super(key: key);

  @override
  State<ColorBlindFilterSelector> createState() => _ColorBlindFilterSelectorState();
}

class _ColorBlindFilterSelectorState extends State<ColorBlindFilterSelector> { // 색맹 필터
  String _selectedFilter = '적록(녹색약, 제2색맹)';

  final List<String> _filters = [
    '적록(녹색약, 제2색맹)',
    '적록(적색약, 제1색맹)',
    '청황(제3색맹)',
  ];

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
            '색맹 필터 모드',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '또는 9가지 색상표의 색을 더 쉽게 구별할 수 있도록 색맹 필터를 적용하세요.',
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
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // 여기에 실제 색맹 필터 적용 로직 추가
                // 예: Provider 등을 통해 필터 상태 갱신
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

// ColorFiltered(
// colorFilter: ColorFilter.matrix(_getColorMatrix(context.watch<ColorFilterProvider>().type)),
// child: MyMainAppView(), // 앱의 나머지 부분
// )

// List<double> _getColorMatrix(ColorBlindType type) {
//   switch (type) {
//     case ColorBlindType.protanopia: // 적색약 (제1색맹)
//       return [
//         0.567, 0.433, 0,     0, 0,
//         0.558, 0.442, 0,     0, 0,
//         0,     0.242, 0.758, 0, 0,
//         0,     0,     0,     1, 0,
//       ];
//     case ColorBlindType.deuteranopia: // 녹색약 (제2색맹)
//       return [
//         0.625, 0.375, 0,     0, 0,
//         0.7,   0.3,   0,     0, 0,
//         0,     0.3,   0.7,   0, 0,
//         0,     0,     0,     1, 0,
//       ];
//     case ColorBlindType.tritanopia: // 청색약 (제3색맹)
//       return [
//         0.95,  0.05,  0,     0, 0,
//         0,     0.433, 0.567, 0, 0,
//         0,     0.475, 0.525, 0, 0,
//         0,     0,     0,     1, 0,
//       ];
//     default:
//       return List<double>.from([
//         1, 0, 0, 0, 0,
//         0, 1, 0, 0, 0,
//         0, 0, 1, 0, 0,
//         0, 0, 0, 1, 0,
//       ]);
//   }
// }
