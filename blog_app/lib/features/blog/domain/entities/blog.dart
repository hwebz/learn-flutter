class Blog {
  final String id;
  final String title;
  final String content;
  final List<String> topics;
  final String? imageUrl;
  final DateTime updatedAt;
  final String userId;
  final String? userName;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.topics,
    required this.imageUrl,
    required this.updatedAt,
    required this.userId,
    this.userName,
  });
}
