import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

class OptionsScreen extends StatelessWidget {
  // 더보기 페이지
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20), //좌, 상, 우, 하
                child: Column(
                    children: [
                      MainLogoHeader(),
                      Text('더보기 페이지'),
                    ]
                )
            )
        )
    );
  }
}
