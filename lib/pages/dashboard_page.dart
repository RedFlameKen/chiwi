import 'package:chiwi/components/dashboard/crud_widget.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Chiwi AI',
          style: TextStyle(
            fontFamily: 'Assistant',
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: ChiwiColors.SERENE_0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe5e0d8), ChiwiColors.ALMOND],
          ),
        ),
        child: ReviewerDashboard(),
      ),
    );
  }
}


// Center(
//           child: Button(
//             onPressed: () async {
//               bool updated = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return CreateReviewerPage();
//                   },
//                 ),
//               );

//               if(updated){
//                 getReviewers();
//               }
//             },
//             text: "Add Reviewer",
//           ),
//         ),
