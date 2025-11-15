import 'package:chiwi/components/dashboard/crud_widget.dart';
import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget{
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReviewerDashboard(),
      ),
    );
  }

}
