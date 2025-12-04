import 'package:chiwi/components/dashboard/crud_widget.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'REVIEWERS',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            letterSpacing: 3,
            color: const Color.fromARGB(255, 247, 244, 240)
          ),
        ),
        backgroundColor: ChiwiColors.MATCHA,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 214, 220, 192), ChiwiColors.ALMOND],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: ReviewerDashboard(),
      ),
    );
  }
}
