import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/quiz_page/review_listener_widget.dart';

class QuizPage extends StatelessWidget {
  final ReviewSessionResponse initResponse;
  final int reviewerId;
  const QuizPage({
    super.key,
    required this.initResponse,
    required this.reviewerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ReviewListenerWidget(
              initResponse: initResponse,
              reviewerId: reviewerId,
            ),
          ),
          Expanded(child: ChiwiWidget()),
        ],
      ),
    );
  }
}
