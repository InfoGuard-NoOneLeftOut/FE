import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';
import 'package:infogaurd_fe/models/region_data.dart';
import 'package:infogaurd_fe/screens/policy.dart';
import 'package:infogaurd_fe/main.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({Key? key}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();

  int currentStep = 0; // 페이지 구분

  String _name = '';
  int _age = 0;
  Gender _gender = Gender.male;
  String _region = '';
  DisabilityLevel _disabilityLevel = DisabilityLevel.severe;
  List<DisabilityType> _disabilityTypes = [];
  bool? _isRegisteredDisabled;
  bool? _hasDisabilityCard;
  String? _incomeLevel;
  String? _householdType;
  List<String> _interestPolicyAreas = [];
  String? _guardianInfo;

  String? _selectedProvince;
  String? _selectedCity;

  @override
  Widget build(BuildContext context) { // 사용자 정보 수집 1페이지
    final greyStyle = ElevatedButton.styleFrom(
      primary: Colors.grey[200], // 배경색
      onPrimary: Colors.black87, // 글자색
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            children: [
              if (currentStep == 0) _buildBasicInfoStep(),
              if (currentStep == 1) _buildGuardianInfoStep(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (currentStep < 1) {
                    setState(() => currentStep += 1);
                  } else {
                    _submitForm();
                  }
                },
                child: Text(currentStep < 1 ? "다음" : "완료"),
                // 이전 버튼 및 0페이지에서 취소 버튼 필요 (취소 버튼 클릭 시 메인 페이지로 돌아갈 수 있도록)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() { // 사용자 정보 수집 1페이지
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🧑‍🦽 이름', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    decoration: _inputDecoration('이름을 입력하세요'),
                    onSaved: (val) => _name = val ?? '',
                  ),
                  const SizedBox(height: 12),

                  const Text('🎂 나이', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('나이를 숫자로 입력하세요'),
                    onSaved: (val) => _age = int.tryParse(val ?? '0') ?? 0,
                  ),
                  const SizedBox(height: 12),

                  const Text('🚻 성별', style: TextStyle(fontSize: 16)),
                  Row(
                    children: Gender.values.map((g) {
                      return Expanded(
                        child: RadioListTile<Gender>(
                          title: Text(g == Gender.male ? '남성' : '여성'),
                          value: g,
                          groupValue: _gender,
                          onChanged: (val) => setState(() => _gender = val!),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  const Text('🏠 지역', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),

                  // 시/도 선택 드롭다운
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration('지역(시/도)을 선택하세요'),
                    value: _selectedProvince,
                    items: regionData.keys.map((province) {
                      return DropdownMenuItem(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                        _selectedCity = null; // 시/군/구 초기화
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // 시/군/구 선택 드롭다운
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration('시/군/구를 선택하세요'),
                    value: _selectedCity,
                    items: _selectedProvince == null
                        ? []
                        : regionData[_selectedProvince!]!.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  const Text('🦾 장애 정도', style: TextStyle(fontSize: 16)),
                  DropdownButtonFormField<DisabilityLevel>(
                    value: _disabilityLevel,
                    items: DisabilityLevel.values.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(
                            level == DisabilityLevel.severe ? '중증' : '경증'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _disabilityLevel = val!),
                    decoration: _inputDecoration(null),
                  ),
                  const SizedBox(height: 12),

                  const Text('🧠 장애 유형', style: TextStyle(fontSize: 16)),
                  Wrap(
                    spacing: 8,
                    children: DisabilityType.values.map((type) {
                      return FilterChip(
                        label: Text(_getDisabilityTypeLabel(type)),
                        selected: _disabilityTypes.contains(type),
                        onSelected: (selected) {
                          setState(() {
                            selected
                                ? _disabilityTypes.add(type)
                                : _disabilityTypes.remove(type);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ))
        ]);
  }
  

  Widget _buildGuardianInfoStep() { // 사용자 정보 수집 2페이지
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📋 장애 등록 여부', style: TextStyle(fontSize: 16)),
        SwitchListTile(
          value: _isRegisteredDisabled ?? false,
          title: const Text('장애 등록을 했어요'),
          onChanged: (val) => setState(() => _isRegisteredDisabled = val),
        ),

        const Text('💳 복지카드 소지', style: TextStyle(fontSize: 16)),
        SwitchListTile(
          value: _hasDisabilityCard ?? false,
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
    );
  }

  void _submitForm() {
    // 데이터 확인 또는 서버 전송 로직
    // 저장 데이터 확인 로직 예시 : print("이름: $name, 나이: $age);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("제출이 완료되었습니다!")),
    );

    // 해당 form을 제출해야 사용자는 맞춤형 추천 정책 확인 가능
    // 그 전까지는 사용자 맞춤형 추천 정책은 숨김 처리

    Navigator.pushReplacement( // 맞춤 정책 페이지로 이동
      context,
      MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2)),
    );
  }
}

InputDecoration _inputDecoration(String? hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  );
}

String _getDisabilityTypeLabel(DisabilityType type) {
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
      return '언어';
  }
}
