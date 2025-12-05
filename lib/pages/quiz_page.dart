import 'package:chiwi/components/drawer/menu_drawer/menu_drawer.dart';
import 'package:chiwi/components/stateless/loading_indicator_widget.dart';
import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/quiz_page/review_listener_widget.dart';

class QuizPage extends StatefulWidget {
  final ReviewSessionResponse initResponse;
  final int reviewerId;
  const QuizPage({
    super.key,
    required this.initResponse,
    required this.reviewerId,
  });

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool _isLoading = false;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ReviewListenerWidget(
              onLoadingChanged: _setLoading,
              initResponse: widget.initResponse,
              reviewerId: widget.reviewerId,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: .center,
              children: [
                ChiwiWidget(),
                if (_isLoading) Column(
                  children: [
                    Expanded(child: LoadingIndicator()),
                    Expanded(child: Container()),
                    Expanded(child: Container()),
                  ],
                ) else Container(),
                Align(
                  alignment: .topRight,
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: Icon(Icons.menu, size: 50),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: MenuDrawer(
        exitDialogTitle: "Exit Reviewer",
        onExit: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
