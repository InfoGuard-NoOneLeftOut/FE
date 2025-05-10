class WelfarePolicy {
  final String id;
  final String title;
  final String description;
  final String provider;
  final String category;

  WelfarePolicy({
    required this.id,
    required this.title,
    required this.description,
    required this.provider,
    required this.category,
  });

  static List<WelfarePolicy> samplePolicies() => [
    WelfarePolicy(id: '1', title: '장애인 연금 지원', description: '소득이 일정 기준 이하인 장애인에게 매월 연금을 지급합니다.', provider: '보건복지부', category: '소득지원'),
    WelfarePolicy(id: '1-2', title: '차상위 장애인 생계지원', description: '차상위 계층 장애인에게 추가 현금 지원을 제공합니다.', provider: '보건복지부', category: '소득지원'),
    WelfarePolicy(id: '2', title: '장애학생 교육 바우처', description: '장애학생의 학습 보조를 위해 교육비를 바우처 형태로 지원합니다.', provider: '교육부', category: '교육/훈련'),
    WelfarePolicy(id: '2-2', title: '장애인 평생교육 지원', description: '성인 장애인을 위한 평생교육 프로그램 수강료를 지원합니다.', provider: '교육부', category: '교육/훈련'),
    WelfarePolicy(id: '3', title: '이동지원 콜택시 서비스', description: '교통이 어려운 중증 장애인을 대상으로 콜택시를 제공합니다.', provider: '국토교통부', category: '이동지원'),
    WelfarePolicy(id: '3-2', title: '교통카드 할인 서비스', description: '장애인 전용 교통카드로 대중교통 요금의 50% 할인을 제공합니다.', provider: '국토교통부', category: '이동지원'),
    WelfarePolicy(id: '4', title: '장애인 주택 개조 지원', description: '거주지 내 편의시설 설치 및 개조 비용을 일부 보조합니다.', provider: '국토교통부', category: '주거지원'),
    WelfarePolicy(id: '4-2', title: '장애인 주택 임대료 보조', description: '저소득 장애인 가구의 임대료 일부를 지원합니다.', provider: 'LH공사', category: '주거지원'),
    WelfarePolicy(id: '5', title: '보장구 지원 사업', description: '휠체어, 보청기 등 장애인 보장구를 저렴하게 지원합니다.', provider: '보건복지부', category: '보건/의료'),
    WelfarePolicy(id: '5-2', title: '건강검진 바우처', description: '장애인을 위한 무료 건강검진 바우처를 제공합니다.', provider: '질병관리청', category: '보건/의료'),
    WelfarePolicy(id: '6', title: '취업 지원 훈련 프로그램', description: '장애인 대상 직업훈련 및 직무적응 교육을 실시합니다.', provider: '고용노동부', category: '취업지원'),
    WelfarePolicy(id: '6-2', title: '맞춤형 취업알선 서비스', description: '장애인 구직자와 기업을 연결해주는 매칭 서비스를 제공합니다.', provider: '한국장애인고용공단', category: '취업지원'),
  ];

  static Map<String, List<WelfarePolicy>> categorizeByCategory(List<WelfarePolicy> all) {
    final map = <String, List<WelfarePolicy>>{};
    for (var p in all) {
      map.putIfAbsent(p.category, () => []).add(p);
    }
    return map;
  }
}