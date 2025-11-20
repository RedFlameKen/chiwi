import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/pages/create_reviewer_page.dart';
import 'package:chiwi/pages/update_reviewer_page.dart';
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

  void getReviewers() {
    _reviewers.clear();
    ReviewerRequester.getReviewers(
      onSuccess: (reviewers) {
        setState(() {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Reviewers recieved!")));
          _reviewers.addAll(reviewers);
        });
      },
    );
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

  Widget? tableItemBuilder(BuildContext context, int index) {
    final reviewer = _reviewers[index];
    return Card(
      child: ListTile(
        title: Text(reviewer.name, style: TextStyle(fontFamily: 'Assistant')),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${reviewer.subject}', style: TextStyle(fontFamily: 'Sans')),
            Text(
              '${reviewer.flashcardsCount}',
              style: TextStyle(fontFamily: 'Sans'),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                Reviewer? updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UpdateReviewerPage(reviewer: reviewer);
                    },
                  ),
                );
                if (updated != null) {
                  setState(() {
                    reviewer.name = updated.name;
                    reviewer.subject = updated.subject;
                    reviewer.dateModified = updated.dateModified;
                    reviewer.dateCreated = updated.dateCreated;
                    reviewer.flashcardsCount = updated.flashcardsCount;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await ReviewerRequester.deleteReviewer(
                  id: reviewer.id,
                  onSuccess: (message) {
                    setState(() {
                      _reviewers.remove(reviewer);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message ?? "Reviewer deleted!")),
                    );
                  },
                  onFail: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message ?? "Failed to delete reviewer"),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
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
            itemBuilder: tableItemBuilder,
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              bool updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateReviewerPage();
                  },
                ),
              );

              if (updated) {
                getReviewers();
              }
            },
            child: Text(
              "Add Reviewer",
              style: TextStyle(fontFamily: 'Sans', fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
