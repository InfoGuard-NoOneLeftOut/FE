import 'package:flutter/material.dart';

class MainLogoHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: Image.asset(
            'assets/logo/logo1.png',
            height: 80,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
