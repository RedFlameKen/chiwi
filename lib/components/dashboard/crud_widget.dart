import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/pages/create_reviewer_page.dart';
import 'package:chiwi/reviewer/reviewer.dart';
import 'package:chiwi/reviewer/reviewer_requester.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewerDashboard extends StatefulWidget {
  @override
  _ReviewerDashboard createState() => _ReviewerDashboard();
}

class _ReviewerDashboard extends State<ReviewerDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<Reviewer> _reviewers = List.empty(growable: true);
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    getReviewers();
  }

  Future<void> getReviewers() async {
    setState(() async {
      _reviewers.clear();
      List<Reviewer> reviewers = await ReviewerRequester.getReviewers();
      _reviewers.addAll(reviewers);
    });
  }

  Future<void> searchReviews() async {
    final response = await http.get(
      Uri.parse('$searchTerm'),
    ); //for searching for reviews
    if (response.statusCode == 200) {
      setState(() {
        _reviewers = json.decode(response.body);
      });
    } else {
      print('Reviewer does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchTerm = _searchController.text;
                  searchReviews();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _reviewers.length,
            itemBuilder: (context, index) {
              final reviewer = _reviewers[index];
              return Card(
                child: ListTile(
                  title: Text(reviewer.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${reviewer.subject}'),
                      Text('${reviewer.flashcardsCount}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // go to update page
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // put delete code here
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: Button(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateReviewerPage();
                  },
                ),
              );
            },
            text: "Add Reviewer",
          ),
        ),
      ],
    );
  }
}
