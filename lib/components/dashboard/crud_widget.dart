import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewerDashboard extends StatefulWidget {
  @override
  _ReviewerDashboard createState() => _ReviewerDashboard();
}

class _ReviewerDashboard extends State<ReviewerDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> getReviews = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    getReviewers();
  }

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
    final response = await http.get(
      Uri.parse('$searchTerm'),
    ); //for searching for reviews
    if (response.statusCode == 200) {
      setState(() {
        getReviews = json.decode(response.body);
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
    );
  }
}
