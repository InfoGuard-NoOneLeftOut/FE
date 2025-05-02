class EasyWords { // 쉬운말 사전
  final String word; //예: "근로계약서"
  final String summary; //쉬운말 요약 (예: “일할 때 쓰는 약속 종이”)
  final String example; // 예문
  final String icon; //단어 이미지
  final List<String> relatedWords; // 관련 단어 리스트

  EasyWords({
    required this.word,
    required this.summary,
    required this.example,
    required this.icon,
    required this.relatedWords,
  });
}
