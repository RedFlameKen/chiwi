import 'package:chiwi/components/dashboard/crud_widget.dart';
<<<<<<< HEAD
import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget{
=======
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Center(
=======
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
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311
        child: ReviewerDashboard(),
      ),
    );
  }
<<<<<<< HEAD

=======
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311
}
