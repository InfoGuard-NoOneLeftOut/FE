import 'package:flutter/material.dart';

enum PolicyType {
  education,
  employment,
  housing,
  medical,
  mobility,
  caregiving,
  culture,
  other,
}

class PolicyList {
  final String id;                         // 고유 식별자
  final String title;                      // 정책명
  final String description;                // 간략한 설명
  final String details;                    // 상세 내용
  final List<PolicyType> categories;       // 정책 분야 (복수 선택 가능)
  final List<String> targetDisabilityTypes; // 해당 장애 유형 (예: ['지체', '청각'])
  final String targetRegion;               // 지역 (예: '전국', '서울특별시')
  final String eligibility;                // 대상 조건 (예: '중증 장애인', '기초생활수급자')
  final String provider;                   // 제공 기관 (예: 보건복지부, 서울시청)
  final String applyMethod;                // 신청 방법 (예: 온라인, 방문 신청)
  final String contact;                    // 문의처
  final String? homepageUrl;               // 정책 페이지 URL (선택)
  final DateTime? startDate;               // 시행 시작일 (선택)
  final DateTime? endDate;                 // 시행 종료일 (선택)
  final bool isFavorite;                   // 즐겨찾기 여부

  PolicyList({
    required this.id,
    required this.title,
    required this.description,
    required this.details,
    required this.categories,
    required this.targetDisabilityTypes,
    required this.targetRegion,
    required this.eligibility,
    required this.provider,
    required this.applyMethod,
    required this.contact,
    this.homepageUrl,
    this.startDate,
    this.endDate,
    this.isFavorite = false,
  });
}
