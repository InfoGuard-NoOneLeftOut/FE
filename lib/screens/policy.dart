import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/welfare_policy.dart';
import 'package:infogaurd_fe/models/job_opportunity.dart';
import 'package:infogaurd_fe/widgets/cards/personalization_consent_card.dart';
import 'package:infogaurd_fe/widgets/lists/recommendation_policy_list.dart';
import 'package:infogaurd_fe/widgets/lists/recommendation_job_list.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';

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
    final popularPolicies = _allPolicies.take(4).toList();
    final recommendedCompanies = _allJobs.map((j) => j.company).toSet().take(4).toList();

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
              indicatorColor: Colors.indigo,
              labelColor: Colors.indigo,
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
                PersonalizationConsentCard(),
                const SizedBox(height: 32),
                const Text('정용진님을 위한 맞춤 정책', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: _selectedPolicyCategory,
                  isExpanded: true,
                  items: policyCategories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (val) => setState(() => _selectedPolicyCategory = val!),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 400,
                  child: RecommendationPolicySection(policies: policyList),
                ),
                // 인기 정책
                const SizedBox(height: 32),
                const Text('요즘 인기있는 정책들', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularPolicies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) {
                      final p = popularPolicies[i];
                      return SizedBox(
                        width: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(p.provider, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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