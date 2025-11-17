import 'dart:convert';

class CreateReviewerRequestData {
  String name;
  String subject;

  CreateReviewerRequestData({required this.name, required this.subject});

  Map<String, String> toMap(){
    return {
      "name": name,
      "subject": subject
    };

  }
  String toJson(){
    return jsonEncode(toMap());
  }


}
