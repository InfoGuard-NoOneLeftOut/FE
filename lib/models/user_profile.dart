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
  // 기본 프로필 표시 내역 (필수 입력 사항)
  final String? imagePath;
  final String name;
  final int age;
  final Gender gender;
  final String region;
  final DisabilityLevel disabilityLevel;
  final List<DisabilityType> disabilityTypes; // 복수 선택 가능

  // 상세 입력 (선택 입력 사항)
  final bool? isRegisteredDisabled; // 장애 등록 여부
  final bool? hasDisabilityCard; // 복지카드 보유 여부
  final String? incomeLevel; // 예: '기초생활수급자', '차상위 계층', '일반'
  final String? householdType; // 예: '단독', '가족', '공동생활가정'
  final List<String>? interestPolicyAreas; // 예: ['교육', '일자리']
  final String? guardianInfo; // 보호자 또는 대리인 정보 (선택 입력)
  
  UserProfile({
    this.imagePath, // nullable
    required this.name,
    required this.age,
    required this.gender,
    required this.region,
    required this.disabilityLevel,
    required this.disabilityTypes,
    this.isRegisteredDisabled,
    this.hasDisabilityCard,
    this.incomeLevel,
    this.householdType,
    this.interestPolicyAreas,
    this.guardianInfo,
  });
}
