import 'package:flutter/material.dart';

class GuardianInfoStep extends StatefulWidget { // 사용자 정보 수집 1페이지
  final GlobalKey<FormState> formKey;
  final void Function(String?) onSavedGuardianName;
  final void Function(String?) onSavedGuardianContact;

  const GuardianInfoStep({
    required this.formKey,
    required this.onSavedGuardianName,
    required this.onSavedGuardianContact,
    Key? key,
  }) : super(key: key);

  @override
  State<GuardianInfoStep> createState() => _GuardianInfoStepState();
}

class _GuardianInfoStepState extends State<GuardianInfoStep> {
  bool _isRegisteredDisabled = false;
  bool _hasDisabilityCard = false;
  String? _incomeLevel;
  String? _householdType;
  List<String> _interestPolicyAreas = [];
  String? _guardianInfo;

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📋 장애 등록 여부', style: TextStyle(fontSize: 16)),
          SwitchListTile(
            value: _isRegisteredDisabled,
            title: const Text('장애 등록을 했어요'),
            onChanged: (val) => setState(() => _isRegisteredDisabled = val),
          ),

          const Text('💳 복지카드 소지', style: TextStyle(fontSize: 16)),
          SwitchListTile(
            value: _hasDisabilityCard,
            title: const Text('복지카드가 있어요'),
            onChanged: (val) => setState(() => _hasDisabilityCard = val),
          ),
          const SizedBox(height: 12),

          const Text('💰 소득 수준', style: TextStyle(fontSize: 16)),
          DropdownButtonFormField<String>(
            items: ['기초생활수급자', '차상위 계층', '일반'].map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (val) => setState(() => _incomeLevel = val),
            decoration: _inputDecoration('선택해주세요'),
          ),
          const SizedBox(height: 12),

          const Text('🏘 가구 형태', style: TextStyle(fontSize: 16)),
          DropdownButtonFormField<String>(
            items: ['단독', '가족', '공동생활가정'].map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (val) => setState(() => _householdType = val),
            decoration: _inputDecoration('선택해주세요'),
          ),
          const SizedBox(height: 12),

          const Text('🎯 관심 정책 분야', style: TextStyle(fontSize: 16)),
          Wrap(
            spacing: 8,
            children: ['교육', '일자리', '주거', '건강'].map((area) {
              return FilterChip(
                label: Text(area),
                selected: _interestPolicyAreas.contains(area),
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? _interestPolicyAreas.add(area)
                        : _interestPolicyAreas.remove(area);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          const Text('👪 보호자 정보 (선택)', style: TextStyle(fontSize: 16)),
          TextFormField(
            decoration: _inputDecoration('보호자 이름 또는 연락처'),
            onSaved: (val) => _guardianInfo = val,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
