import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';
import 'package:infogaurd_fe/main.dart';
import 'package:infogaurd_fe/widgets/forms/basic_info_step.dart'; // 0페이지 (필수 입력)
import 'package:infogaurd_fe/widgets/forms/guardian_info_step.dart'; // 1페이지 (선택 입력)
import 'package:infogaurd_fe/widgets/forms/borderline_info_step.dart'; // 2페이지 (경계선)

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
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            children: [
              if (currentStep == 0)
                BasicInfoStep(
                  // name: _name,
                  // age: _age,
                  gender: _gender,
                  disabilityLevel: _disabilityLevel,
                  disabilityTypes: _disabilityTypes,
                  selectedProvince: _selectedProvince,
                  selectedCity: _selectedCity,
                  onSavedName: (val) => _name = val ?? '',
                  onSavedAge: (val) => _age = int.tryParse(val ?? '0') ?? 0,
                  onGenderChanged: (val) => setState(() => _gender = val!),
                  onDisabilityLevelChanged: (val) => setState(() => _disabilityLevel = val!),
                  onDisabilityTypeToggle: (val, isSelected) {
                    setState(() {
                      isSelected
                          ? _disabilityTypes.add(val)
                          : _disabilityTypes.remove(val);
                    });
                  },
                  onProvinceChanged: (val) => setState(() => _selectedProvince = val),
                  onCityChanged: (val) => setState(() => _selectedCity = val),
                  formKey: _formKey,
                ), // 0페이지 - 필수 입력 페이지
              if (currentStep == 1)
              GuardianInfoStep(
                onSavedGuardianName: (val) => _guardianInfo = val ?? '',
                onSavedGuardianContact: (val) {}, // 필요 시 구현
                formKey: _formKey,
              ), // 1페이지 - 선택 입력 페이지
              if (currentStep == 2 && _disabilityTypes.contains(DisabilityType.speech))
                BorderlineInfoStep(
                  onSavedDiagnosis: (val) {},     // 필요 시 상태 저장 구현
                  onSavedSchool: (val) {},        // 필요 시 상태 저장 구현
                  onSavedSpecialNote: (val) {},   // 필요 시 상태 저장 구현
                  formKey: _formKey,
                ), // 2페이지 - 경계선 지능인 페이지 (0페이지에서 경계선 선택 시)
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 왼쪽 버튼: 취소 또는 이전
                  if (currentStep == 0)
                    OutlinedButton(
                      onPressed: () {
                        // Navigator.pop 대신 MainScreen으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      child: const Text("취소"),
                    )
                  else if (currentStep == 1)
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          currentStep -= 1;
                        });
                      },
                      child: const Text("이전"),
                    ),

                  // 오른쪽 버튼: 다음 또는 완료
                  ElevatedButton(
                    onPressed: () {
                      if (currentStep == 0) { // 1페이지 일 경우 다음 버튼 클릭 시 페이지 +1
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() => currentStep += 1);
                        }
                      } else if (currentStep == 1) {
                        // 경계선일 경우 한 단계 더
                        if (_disabilityTypes.contains(DisabilityType.speech)) {
                          setState(() => currentStep += 1);
                        } else {
                          _submitForm();
                        }
                      } else {
                        _submitForm();
                      }
                    },
                    child: Text(currentStep < 2 ? "다음" : "완료"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // 모든 onSaved 값 저장

      print("========= 사용자 입력 정보 =========");
      print("이름: $_name");
      print("나이: $_age");
      print("성별: $_gender");
      print("지역: $_region");
      print("장애 정도: $_disabilityLevel");
      print("장애 유형: $_disabilityTypes");
      print("장애 등록 여부: $_isRegisteredDisabled");
      print("복지카드 소지: $_hasDisabilityCard");
      print("소득 수준: $_incomeLevel");
      print("가구 형태: $_householdType");
      print("관심 정책 분야: $_interestPolicyAreas");
      print("보호자 정보: $_guardianInfo");
      // 필요한 경우 경계선 입력 값들도 추가
      print("===================================");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("제출이 완료되었습니다!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2)),
      );
    }
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
