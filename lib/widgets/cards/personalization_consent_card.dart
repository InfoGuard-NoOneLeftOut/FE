import 'package:flutter/material.dart';

class PersonalizationConsentCard extends StatefulWidget {
  const PersonalizationConsentCard({Key? key}) : super(key: key);
  @override
  _PersonalizationConsentCardState createState() => _PersonalizationConsentCardState();
}

class _PersonalizationConsentCardState extends State<PersonalizationConsentCard> {
  bool _consentGiven = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.touch_app, color: Colors.indigo),
            SizedBox(width: 12),
            Expanded(child: Text('맞춤 추천을 위해 개인정보 수집에 동의하시겠습니까?', style: TextStyle(fontSize: 14))),
            Switch(value: _consentGiven, onChanged: (v) => setState(() => _consentGiven = v)),
          ],
        ),
      ),
    );
  }
}