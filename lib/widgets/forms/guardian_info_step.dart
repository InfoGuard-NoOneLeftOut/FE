import 'package:flutter/material.dart';

class GuardianInfoStep extends StatefulWidget {
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('장애 등록 여부'),
          SwitchListTile.adaptive(
            value: _isRegisteredDisabled,
            title: const Text('장애 등록을 했어요'),
            onChanged: (val) => setState(() => _isRegisteredDisabled = val),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),

          _sectionTitle('복지카드 소지 여부'),
          SwitchListTile.adaptive(
            value: _hasDisabilityCard,
            title: const Text('복지카드가 있어요'),
            onChanged: (val) => setState(() => _hasDisabilityCard = val),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),

          _sectionTitle('소득 수준'),
          DropdownButtonFormField<String>(
            items: ['기초생활수급자', '차상위 계층', '일반']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _incomeLevel = val),
            decoration: _inputDecoration('선택해주세요'),
          ),
          const SizedBox(height: 16),

          _sectionTitle('가구 형태'),
          DropdownButtonFormField<String>(
            items: ['단독', '가족', '공동생활가정']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _householdType = val),
            decoration: _inputDecoration('선택해주세요'),
          ),
          const SizedBox(height: 16),

          _sectionTitle('관심 정책 분야'),
          Wrap(
            spacing: 8,
            children: ['교육', '일자리', '주거', '건강'].map((area) {
              return FilterChip(
                label: Text(area),
                selected: _interestPolicyAreas.contains(area),
                onSelected: (selected) {
                  setState(() {
                    selected ? _interestPolicyAreas.add(area) : _interestPolicyAreas.remove(area);
                  });
                },
                selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          _sectionTitle('보호자 정보 (선택)'),
          TextFormField(
            decoration: _inputDecoration('보호자 이름 또는 연락처'),
            onSaved: (val) => _guardianInfo = val,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
