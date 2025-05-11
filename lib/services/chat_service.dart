import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey;
  final String _url = 'https://api.openai.com/v1/chat/completions';

  ChatService({required this.apiKey});

  Future<String> sendMessageHistory(List<Map<String, String>> history) async {
    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        // ① 더 강력한 모델로 변경
        'model': 'gpt-4',
        'messages': [
          // ② 시스템 메시지에 마크다운 금지 추가
          {
            'role': 'system',
            'content': '당신은 경계성 장애인을 위해 친절하고 쉽게 설명해 주는 챗봇입니다. 답변 시 별표나 마크다운 없이, 자연스럽고 간결한 문장으로만 출력하세요.'
          },
          // 그 외 히스토리(사용자·봇) 그대로
          ...history,
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (res.statusCode == 200) {
      // UTF-8 디코딩
      final body = utf8.decode(res.bodyBytes);
      final data = jsonDecode(body);
      // ③ 응답 문자열에서 ** 제거
      String content = data['choices'][0]['message']['content'].trim();
      return content.replaceAll('**', '');
    } else {
      throw Exception('API 오류: ${res.statusCode}');
    }
  }
}