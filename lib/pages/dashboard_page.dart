import 'package:chiwi/components/dashboard/crud_widget.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviewers'),
        backgroundColor: ChiwiColors.CHAI,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ChiwiColors.VANILLA, ChiwiColors.ALMOND],
          ),
        ),
        child: ReviewerDashboard(),
      ),
    );
  }
}
