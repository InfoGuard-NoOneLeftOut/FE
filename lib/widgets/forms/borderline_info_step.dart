import 'package:flutter/material.dart';

class BorderlineInfoStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String?) onSavedSchool;
  final void Function(String?) onSavedDiagnosis;
  final void Function(String?) onSavedSpecialNote;

  const BorderlineInfoStep({
    required this.formKey,
    required this.onSavedSchool,
    required this.onSavedDiagnosis,
    required this.onSavedSpecialNote,
    Key? key,
  }) : super(key: key);

  @override
  State<BorderlineInfoStep> createState() => _BorderlineInfoStepState();
}

class _BorderlineInfoStepState extends State<BorderlineInfoStep> {
  final Map<String, String?> _selectedChips = {};
  String? _commuteMethod;
  String? _commuteTime;

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  );

  Widget _buildChipSelector(String title, List<String> options) {
    final selected = _selectedChips[title];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isSelected = selected == opt;
            return FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedChips[title] = opt;
                });
              },
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChipSelector("일상생활 자립도", ["높음", "보통", "낮음"]),
          _buildChipSelector("인지 지원 필요도", ["낮음", "중간", "높음"]),
          _buildChipSelector("의사소통 선호 방식", ["말하기/듣기", "텍스트 읽기", "시각적 아이콘", "혼합형"]),
          _buildChipSelector("학습·업무 속도", ["느림", "보통", "빠름"]),
          _buildChipSelector("작업 환경 선호", ["조용한 공간", "팀 협업", "혼합형"]),
          _buildChipSelector("직무 훈련/자격증", ["컴퓨터 기초", "서비스 직무", "언어 교육"]),
          _buildChipSelector("희망 근무 형태", ["정규직", "파트타임", "인턴"]),

          _sectionTitle("통근 수단"),
          DropdownButtonFormField<String>(
            items: ["대중교통", "도보", "가족차량"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _commuteMethod = val),
            decoration: _inputDecoration("통근 수단 선택"),
          ),
          const SizedBox(height: 16),

          TextFormField(
            keyboardType: TextInputType.number,
            decoration: _inputDecoration("최대 통근 시간 (분)"),
            onSaved: (val) => _commuteTime = val,
          ),
          const SizedBox(height: 16),

          _buildChipSelector("디지털 기기 사용 능력", ["기초", "중간", "높음"]),
          _buildChipSelector("스트레스 요인", ["소음", "복잡한 절차", "대인관계", "없음"]),
        ],
      ),
    );
  }
}
