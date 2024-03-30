class Blog {
  final String id;
  final String title;
  final String content;
  final List<String> topics;
  final String? imageUrl;
  final DateTime updatedAt;
  final String userId;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.topics,
    required this.imageUrl,
    required this.updatedAt,
    required this.userId,
  });
}
