import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget { // 사용자 페이지
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('사용자 페이지')),
    );
  }
}
