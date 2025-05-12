class JobOpportunity {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String requirements;

  JobOpportunity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.requirements,
  });

  static List<JobOpportunity> sampleJobs() => [
    JobOpportunity(id: 'j1', title: '모바일 앱 개발자', company: '테크랩스', location: '서울시 강남구', type: '개발', requirements: 'Flutter, Dart 활용 가능'),
    JobOpportunity(id: 'j1-2', title: '백엔드 개발자', company: '엔터프라이즈', location: '서울시 마포구', type: '개발', requirements: 'Node.js, Express 경험 보유'),
    JobOpportunity(id: 'j2', title: '웹 디자이너', company: '킹콩 디자인', location: '부산시 해운대구', type: '디자인', requirements: 'UI/UX, 그래픽 디자인 가능'),    JobOpportunity(id: 'j2-2', title: '접근성 UI/UX 디자이너', company: '접근성랩', location: '서울시 종로구', type: '디자인', requirements: '접근성 가이드라인 경험'),
    JobOpportunity(id: 'j3', title: '데이터 분석가', company: '데이터코리아', location: '대전시 유성구', type: '분석', requirements: 'Python, SQL, BI 도구 경험'),
    JobOpportunity(id: 'j3-2', title: 'AI 연구 보조', company: 'AI테크', location: '판교', type: '분석', requirements: 'ML/DL 지식 보유'),    JobOpportunity(id: 'j4', title: '고객지원 상담사', company: '행복콜센터', location: '인천시 남동구', type: '지원', requirements: '소통 능력 우수자'),
    JobOpportunity(id: 'j4-2', title: '장애인 복지 상담사', company: '복지상담센터', location: '광주시 북구', type: '지원', requirements: '장애 복지 제도 이해'),
  ];
}