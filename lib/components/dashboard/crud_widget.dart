<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
=======
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/pages/create_reviewer_page.dart';
import 'package:chiwi/pages/update_reviewer_page.dart';
import 'package:chiwi/reviewer/reviewer.dart';
import 'package:chiwi/reviewer/reviewer_requester.dart';
import 'package:flutter/material.dart';
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311

class ReviewerDashboard extends StatefulWidget {
  @override
  _ReviewerDashboard createState() => _ReviewerDashboard();
}

class _ReviewerDashboard extends State<ReviewerDashboard> {
  final TextEditingController _searchController = TextEditingController();
<<<<<<< HEAD
  List<dynamic> getReviews = [];
  String searchTerm = '';
=======
  List<Reviewer> _reviewers = List.empty(growable: true);
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311

  @override
  void initState() {
    super.initState();
    getReviewers();
  }

<<<<<<< HEAD
  Future<void> getReviewers() async {
    final response = await http.get(Uri.parse('')); //call db uri here
    if (response.statusCode == 200) {
      setState(() {
        getReviews = json.decode(response.body);
      });
    } else {
      print('No Reviewers made yet');
    }
  }

  Future<void> searchReviews() async {
    final response = await http.get(Uri.parse('$searchTerm')); //for searching for reviews
    if (response.statusCode == 200) {
      setState(() {
        getReviews = json.decode(response.body);
      });
    } else {
      print('Reviewer does not exist');
    }
=======
  void getReviewers({String? query}) {
    _reviewers.clear();
    ReviewerRequester.getReviewers(
      query: query,
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

  Widget? tableItemBuilder(BuildContext context, int index) {
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
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviewers'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              searchTerm = _searchController.text;
              searchReviews();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getReviews.length,
              itemBuilder: (context, index) {
                final review = getReviews[index];
                return Card(
                  child: ListTile(
                    title: Text(review['reviews']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${review['name']}'),
                        Text('${review['type']}'),
                       
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
        ],
      ),
=======
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
                  String searchTerm = _searchController.text;
                  getReviewers(query: searchTerm);
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
          child: Button(
            onPressed: () async {
              bool updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateReviewerPage();
                  },
                ),
              );

              if(updated){
                getReviewers();
              }
            },
            text: "Add Reviewer",
          ),
        ),
      ],
>>>>>>> 106f6c223c3d29b370a016e874ce57bda1346311
    );
  }
}
