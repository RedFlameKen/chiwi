import 'dart:convert';

class ReviewerRequestData {
  String name;
  String subject;

  ReviewerRequestData({required this.name, required this.subject});

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
