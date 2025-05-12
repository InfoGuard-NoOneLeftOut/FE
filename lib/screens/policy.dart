import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/welfare_policy.dart';
import 'package:infogaurd_fe/models/job_opportunity.dart';
import 'package:infogaurd_fe/widgets/cards/personalization_consent_card.dart';
import 'package:infogaurd_fe/widgets/lists/recommendation_policy_list.dart';
import 'package:infogaurd_fe/widgets/lists/recommendation_job_list.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';
import 'package:infogaurd_fe/widgets/lists/personalized_policy_list.dart';
import 'package:infogaurd_fe/widgets/cards/popular_policies_card.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late final List<WelfarePolicy> _allPolicies;
  late final Map<String, List<WelfarePolicy>> _policyMap;
  String _selectedPolicyCategory = '전체';

  late final List<JobOpportunity> _allJobs;
  String _filterLocation = '전체';
  String _filterType = '전체';

  @override
  void initState() {
    super.initState();
    _allPolicies = WelfarePolicy.samplePolicies();
    _policyMap = {'전체': _allPolicies, ...WelfarePolicy.categorizeByCategory(_allPolicies)};
    _allJobs = JobOpportunity.sampleJobs();
  }

  @override
  Widget build(BuildContext context) {
    final policyCategories = _policyMap.keys.toList();
    final policyList = _policyMap[_selectedPolicyCategory] ?? [];
    final locations = ['전체', ..._allJobs.map((j) => j.location).toSet()];
    final types = ['전체', ..._allJobs.map((j) => j.type).toSet()];
    final filteredJobs = _allJobs.where((j) {
      final locOk = _filterLocation == '전체' || j.location == _filterLocation;
      final typeOk = _filterType == '전체' || j.type == _filterType;
      return locOk && typeOk;
    }).toList();
    final recommendedCompanies = _allJobs.map((j) => j.company).toSet().take(4).toList();

    final List<Policy> popularPolicies = [
      Policy(
        title: '장애인 연금 지원',
        description: '득이 일정 기준 이하인 장애인에게 매월 연금을 지급합니다.',
        imageUrl: '/assets/images/card1.png',
        provider: '보건복지부',
      ),
      Policy(
        title: '차상위 장애인 생계지원',
        description: '차상위 계층 장애인에게 추가 현금 지원을 제공합니다.',
        imageUrl: '/assets/images/card2.png',
        provider: '보건복지부',
      ),
      Policy(
        title: '장애학생 교육 바우처',
        description: '장애학생의 학습 보조를 위해 교육비를 바우처 형태로 지원합니다.',
        imageUrl: '/assets/images/card3.png',
        provider: '교육부',
      ),
      Policy(
        title: '장애인 평생교육 지원',
        description: '성인 장애인을 위한 평생교육 프로그램 수강료를 지원합니다.',
        imageUrl: '/assets/images/card4.png',
        provider: '교육부',
      ),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.black54,
              tabs: [Tab(text: '맞춤 정책'), Tab(text: '맞춤 채용')],
            ),
            flexibleSpace: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Align(
                alignment: Alignment.center,
                child: MainLogoHeader(),
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: [
            // 맞춤 정책: 리스팅 전체, 스크롤 가능한 ListView
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 32),
                PersonalizationConsentCard(), // 맞춤 정책 정보 수집 요청 카드
                const SizedBox(height: 48),
                PersonalizedPolicyList( // 개인 맞춤 정책 리스트
                  selectedCategory: _selectedPolicyCategory,
                  policyCategories: policyCategories,
                  policies: policyList,
                  onCategoryChanged: (val) {
                    setState(() => _selectedPolicyCategory = val);
                  },
                ),
  
                // 이번 달 인기 정책
                PopularPoliciesCard(popularPolicies: popularPolicies),
              ],
            ),

            // 맞춤 채용: 전체 채용 리스트 & 추천 기업
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 32),
                PersonalizationConsentCard(),
                const SizedBox(height: 16),
                const Text('맞춤 기업 추천', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedCompanies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) => Chip(label: Text(recommendedCompanies[i])),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _filterLocation,
                        isExpanded: true,
                        items: locations.map((loc) => DropdownMenuItem(value: loc, child: Text(loc))).toList(),
                        onChanged: (val) => setState(() => _filterLocation = val!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _filterType,
                        isExpanded: true,
                        items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        onChanged: (val) => setState(() => _filterType = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 500,
                  child: RecommendationJobSection(jobs: filteredJobs),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

