class Reviewer {
  double id;
  String name;
  String? subject;
  DateTime? dateCreated;
  DateTime? dateModified;
  int flashcardsCount;

  Reviewer({
    required this.id,
    required this.name,
    this.subject,
    this.dateCreated,
    this.dateModified,
    this.flashcardsCount = 0
  });

}
