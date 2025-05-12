import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';
import 'package:infogaurd_fe/models/region_data.dart';

class BasicInfoStep extends StatelessWidget { // 사용자 정보 수집 0페이지
  final GlobalKey<FormState> formKey;
  final String? selectedProvince;
  final String? selectedCity;
  final void Function(String?) onProvinceChanged;
  final void Function(String?) onCityChanged;
  final void Function(String?) onSavedName;
  final void Function(String?) onSavedAge;
  final Gender gender;
  final void Function(Gender?) onGenderChanged;
  final DisabilityLevel disabilityLevel;
  final void Function(DisabilityLevel?) onDisabilityLevelChanged;
  final List<DisabilityType> disabilityTypes;
  final void Function(DisabilityType, bool) onDisabilityTypeToggle;

  const BasicInfoStep({
    required this.formKey,
    required this.selectedProvince,
    required this.selectedCity,
    required this.onProvinceChanged,
    required this.onCityChanged,
    required this.onSavedName,
    required this.onSavedAge,
    required this.gender,
    required this.onGenderChanged,
    required this.disabilityLevel,
    required this.onDisabilityLevelChanged,
    required this.disabilityTypes,
    required this.onDisabilityTypeToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String? hint) => InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    TextStyle labelStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("이름", labelStyle),
          TextFormField(
            decoration: inputDecoration('이름을 입력하세요'),
            onSaved: onSavedName,
            validator: (value) =>
            value == null || value.isEmpty ? '이름을 입력해주세요' : null,
          ),
          const SizedBox(height: 16),

          _label("나이", labelStyle),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: inputDecoration('숫자로 입력'),
            onSaved: onSavedAge,
            validator: (value) =>
            value == null || value.isEmpty ? '나이를 입력해주세요' : null,
          ),
          const SizedBox(height: 16),

          _label("성별", labelStyle),
          Row(
            children: Gender.values.map((g) {
              return Expanded(
                child: RadioListTile<Gender>(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  title: Text(g == Gender.male ? '남성' : '여성'),
                  value: g,
                  groupValue: gender,
                  onChanged: onGenderChanged,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          _label("지역", labelStyle),
          DropdownButtonFormField<String>(
            decoration: inputDecoration('시/도를 선택하세요'),
            value: selectedProvince,
            items: regionData.keys
                .map((province) => DropdownMenuItem(
                value: province, child: Text(province)))
                .toList(),
            onChanged: onProvinceChanged,
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            decoration: inputDecoration('시/군/구를 선택하세요'),
            value: selectedCity,
            items: selectedProvince == null
                ? []
                : regionData[selectedProvince!]!
                .map((city) =>
                DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: onCityChanged,
          ),
          const SizedBox(height: 16),

          _label("장애 정도", labelStyle),
          DropdownButtonFormField<DisabilityLevel>(
            value: disabilityLevel,
            items: DisabilityLevel.values
                .map((level) => DropdownMenuItem(
                value: level,
                child: Text(level == DisabilityLevel.severe ? '중증' : '경증')))
                .toList(),
            onChanged: onDisabilityLevelChanged,
            decoration: inputDecoration(null),
          ),
          const SizedBox(height: 16),

          _label("장애 유형", labelStyle),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DisabilityType.values.map((type) {
              final selected = disabilityTypes.contains(type);
              return FilterChip(
                label: Text(_getLabel(type)),
                selected: selected,
                selectedColor: Colors.black87,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.grey[200],
                onSelected: (isSelected) =>
                    onDisabilityTypeToggle(type, isSelected),
                labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black87),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _label(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: style),
    );
  }

  String _getLabel(DisabilityType type) {
    switch (type) {
      case DisabilityType.physical:
        return '지체';
      case DisabilityType.brainLesion:
        return '뇌병변';
      case DisabilityType.visual:
        return '시각';
      case DisabilityType.hearing:
        return '청각';
      case DisabilityType.mental:
        return '정신';
      case DisabilityType.autism:
        return '자폐';
      case DisabilityType.speech:
        return '경계선';
    }
  }
}
