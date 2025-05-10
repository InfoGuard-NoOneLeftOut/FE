import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey;
  final String _url = 'https://api.openai.com/v1/chat/completions';

  ChatService({required this.apiKey});

  /// 히스토리 전체를 보내 컨텍스트를 유지하며 답변을 받아옵니다.
  Future<String> sendMessageHistory(List<Map<String, String>> history) async {
    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': history,
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (res.statusCode == 200) {
      final body = utf8.decode(res.bodyBytes);
      final data = jsonDecode(body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('API 오류: ${res.statusCode}');
    }
  }
}