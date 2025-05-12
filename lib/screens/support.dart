import 'package:flutter/material.dart';
import 'package:infogaurd_fe/services/chat_service.dart';
import 'package:infogaurd_fe/models/chat_message.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatService _chatService;

  // UI용 메시지 리스트
  final List<ChatMessage> _messages = [];

  // API용 히스토리 (system/user/assistant)
  final List<Map<String, String>> _history = [
    {'role': 'system', 'content': '당신은 경계성 장애인을 친절하고 쉽게 도와주는 챗봇입니다.'}
  ];

  @override
  void initState() {
    super.initState();
    const apiKey = 'Enter your API key'; // API KEY
    _chatService = ChatService(apiKey: apiKey);
    _messages.add(ChatMessage(text: '안녕하세요! 무엇을 도와드릴까요?', isUser: false));
  }

  Future<void> _handleSend() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _history.add({'role': 'user', 'content': text});
      _inputController.clear();
    });

    String reply;
    try {
      reply = await _chatService.sendMessageHistory(_history);
    } catch (e) {
      reply = '죄송해요, 오류가 발생했어요.';
    }

    setState(() {
      _messages.add(ChatMessage(text: reply, isUser: false));
      _history.add({'role': 'assistant', 'content': reply});
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0), // 좌, 상, 우, 하
        child: Column(
          children: [
            MainLogoHeader(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _messages.length,
                itemBuilder: (ctx, i) {
                  final msg = _messages[i];
                  return Align(
                    alignment: msg.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: msg.isUser
                            ? const Color(0xFF007AFF) // iOS 파란색
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          if (!msg.isUser)
                            const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Text(
                        msg.text,
                        style: TextStyle(
                          color: msg.isUser ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: 0.5,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: '메세지를 입력하세요...',
                  border: InputBorder.none,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _handleSend,
            child: const CircleAvatar(
              backgroundColor: Color(0xFF007AFF),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
