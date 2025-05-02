import 'package:flutter/material.dart';

enum Gender { male, female }
enum DisabilityLevel { severe, mild } // 장애 등급 (중증, 경증)
enum DisabilityType {
  physical, // 지체장애
  brainLesion, // 뇌병변
  visual, // 시각
  hearing, // 청각
  mental, // 정신
  autism, // 자폐
  speech, // 언어
}

class UserProfile {
  final String name;
  final int age;
  final Gender gender;
  final String region;
  final DisabilityLevel disabilityLevel;
  final List<DisabilityType> disabilityTypes; // 복수 선택 가능

  UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.region,
    required this.disabilityLevel,
    required this.disabilityTypes,
  });
}
