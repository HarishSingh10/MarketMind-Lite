class Course {
  final String id;
  final String title;
  final String shortDescription;
  final String fullContent; // Simple static content for now
  final double progress; // 0.0 to 1.0

  Course({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullContent,
    this.progress = 0.0,
  });
}
