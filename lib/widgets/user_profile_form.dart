import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/user_profile.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({Key? key}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, List<String>> regionData = {
    '서울특별시': ['종로구', '중구', '용산구', '성동구', '광진구', '동대문구', '중랑구', '성북구', '강북구', '도봉구', '노원구', '은평구', '서대문구', '마포구', '양천구', '강서구', '구로구', '금천구', '영등포구', '동작구', '관악구', '서초구', '강남구', '송파구', '강동구'],
    '부산광역시': ['중구', '서구', '동구', '영도구', '부산진구', '동래구', '남구', '북구', '해운대구', '사하구', '금정구', '강서구', '연제구', '수영구', '사상구', '기장군'],
    '대구광역시': ['중구', '동구', '서구', '남구', '북구', '수성구', '달서구', '달성군', '군위군'],
    '인천광역시': ['중구', '동구', '미추홀구', '연수구', '남동구', '부평구', '계양구', '서구', '강화군', '옹진군'],
    '광주광역시': ['동구', '서구', '남구', '북구', '광산구'],
    '대전광역시': ['동구', '중구', '서구', '유성구', '대덕구'],
    '울산광역시': ['중구', '남구', '동구', '북구', '울주군'],
    '세종특별자치시': ['조치원읍', '연기면', '연동면', '부강면', '금남면', '장군면', '연서면', '전의면', '전동면', '소정면', '한솔동', '새롬동', '나성동', '다정동', '도담동', '어진동', '해밀동', '아름동', '종촌동', '고운동', '보람동', '대평동', '소담동', '반곡동'],
    '경기도': ['수원시', '성남시', '고양시', '용인시', '부천시', '안산시', '안양시', '남양주시', '화성시', '평택시', '의정부시', '시흥시', '파주시', '광명시', '김포시', '군포시', '광주시', '이천시', '양주시', '오산시', '구리시', '안성시', '포천시', '의왕시', '하남시', '여주시', '양평군', '동두천시', '가평군', '연천군'],
    '강원특별자치도': ['춘천시', '원주시', '강릉시', '동해시', '태백시', '속초시', '삼척시', '홍천군', '횡성군', '영월군', '평창군', '정선군', '철원군', '화천군', '양구군', '인제군', '고성군', '양양군'],
    '충청북도': ['청주시', '충주시', '제천시', '보은군', '옥천군', '영동군', '증평군', '진천군', '괴산군', '음성군', '단양군'],
    '충청남도': ['천안시', '공주시', '보령시', '아산시', '서산시', '논산시', '계룡시', '당진시', '금산군', '부여군', '서천군', '청양군', '홍성군', '예산군', '태안군'],
    '전라북도': ['전주시', '군산시', '익산시', '정읍시', '남원시', '김제시', '완주군', '진안군', '무주군', '장수군', '임실군', '순창군', '고창군', '부안군'],
    '전라남도': ['목포시', '여수시', '순천시', '나주시', '광양시', '담양군', '곡성군', '구례군', '고흥군', '보성군', '화순군', '장흥군', '강진군', '해남군', '영암군', '무안군', '함평군', '영광군', '장성군', '완도군', '진도군', '신안군'],
    '경상북도': ['포항시', '경주시', '김천시', '안동시', '구미시', '영주시', '영천시', '상주시', '문경시', '경산시', '군위군', '의성군', '청송군', '영양군', '영덕군', '청도군', '고령군', '성주군', '칠곡군', '예천군', '봉화군', '울진군', '울릉군'],
    '경상남도': ['창원시', '진주시', '통영시', '사천시', '김해시', '밀양시', '거제시', '양산시', '의령군', '함안군', '창녕군', '고성군', '남해군', '하동군', '산청군', '함양군', '거창군', '합천군'],
    '제주특별자치도': ['제주시', '서귀포시'],
  };

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
    final greyStyle = ElevatedButton.styleFrom(
      primary: Colors.grey[200],  // 배경색
      onPrimary: Colors.black87,  // 글자색
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Form(
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
                      child: Text(level == DisabilityLevel.severe ? '중증' : '경증'),
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

                Center(
                  child: ElevatedButton(
                    style: greyStyle,
                    onPressed: () {
                      _formKey.currentState?.save();
                      // TODO: 저장 로직 작성
                      // 제출하기 버튼 입력 시 사용자 정보 저장 후 맞춤정책 페이지로 이동
                    },
                    child: const Text('제출하기'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ),
      ),
    );
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
}
