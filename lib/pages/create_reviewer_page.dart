import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/components/input/text_input.dart';
import 'package:chiwi/reviewer/reviewer_requester.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class CreateReviewerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateReviewerPageState();
}

class _CreateReviewerPageState extends State<CreateReviewerPage> {
  TextEditingController? _nameController;
  TextEditingController? _subjectController;
  late TextInput _nameInput;
  late TextInput _subjectInput;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
  }

  TextInput createNameInput() {
    return TextInput(hint: "Name", textController: _nameController);
  }

  TextInput createSubjectInput() {
    return TextInput(hint: "Subject", textController: _subjectController);
  }

  @override
  Widget build(BuildContext context) {
    _nameInput = createNameInput();
    _subjectInput = createSubjectInput();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reviewer"),
        backgroundColor: ChiwiColors.CHAI,
      ),
      body: Container(
        padding: .only(left: 50, right: 50),
        child: ListView(
          scrollDirection: .vertical,
          children: [
            Container(
              child: Column(
                mainAxisSize: .min,
                mainAxisAlignment: .start,
                children: [
                  Container(
                    margin: .only(top: 10, bottom: 10),
                    child: _nameInput,
                  ),
                  Container(
                    margin: .only(top: 10, bottom: 10),
                    child: _subjectInput,
                  ),
                ],
              ),
            ),
            Button(
              onPressed: () async {
                await ReviewerRequester.createReviewer(
                  name: _nameController!.text.toString(),
                  subject: _subjectController!.text.toString(),
                  onSuccess: (message) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message ?? "Reviewer created!")),
                    );
                  },
                  onFail: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message ?? "Failed to create reviewer"),
                      ),
                    );
                  },
                );
              },
              text: "Create",
            ),
          ],
        ),
      ),
    );
  }
}
