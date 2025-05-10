import 'package:flutter/material.dart';
import 'package:infogaurd_fe/models/job_opportunity.dart';

class RecommendationJobSection extends StatelessWidget {
  final List<JobOpportunity> jobs;
  const RecommendationJobSection({Key? key, required this.jobs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return Center(child: Text('적합한 채용 공고가 없습니다.'));
    return ListView.separated(
      itemCount: jobs.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final j = jobs[i];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: Icon(Icons.work_outline, color: Colors.green),
            title: Text(j.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${j.company} • ${j.location}\n요구: ${j.requirements}'),
            trailing: Text(j.type, style: TextStyle(fontSize: 12, color: Colors.black54)),
          ),
        );
      },
    );
  }
}