import 'package:flutter/material.dart';
import 'package:infogaurd_fe/utils/color.dart';

class FontSizeSliderWidget extends StatefulWidget {
  final double initialFontSize;
  final ValueChanged<double> onFontSizeChanged;

  const FontSizeSliderWidget({
    Key? key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  }) : super(key: key);

  @override
  State<FontSizeSliderWidget> createState() => _FontSizeSliderWidgetState();
}

class _FontSizeSliderWidgetState extends State<FontSizeSliderWidget> {
  late double _fontSize;
  late double _appliedFontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
    _appliedFontSize = widget.initialFontSize;
  }

  void _applyFontSize() {
    setState(() {
      _appliedFontSize = _fontSize;
    });
    widget.onFontSizeChanged(_appliedFontSize);
  }

  @override
  Widget build(BuildContext context) {
    final bool isChanged = _fontSize != _appliedFontSize;

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
            '큰 글씨 모드',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '글씨 크기 미리 보기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '슬라이더 조정 시 글자의 크기가 변경됩니다.',
                  style: TextStyle(
                    fontSize: _fontSize, // 변경된 부분
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorProps.whiteOpacity03, width: 2),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Text('가', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 14,
                    max: 32,
                    divisions: 4,
                    activeColor: Colors.blueAccent,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                      // 실시간 반영 (원하는 경우)
                      // widget.onFontSizeChanged(value);
                    },
                  ),
                ),
                const Text('가', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: isChanged ? _applyFontSize : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    return Colors.blueAccent;
                  },
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('적용'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
