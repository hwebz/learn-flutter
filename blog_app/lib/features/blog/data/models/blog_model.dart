import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.topics,
    required super.imageUrl,
    required super.updatedAt,
    required super.userId,
    super.userName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'topics': topics,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'topics': topics,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
      'user_name': userName
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      imageUrl: map['image_url'] as String?,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      userId: map['user_id'] as String,
      userName: map['user_name'] as String?,
    );
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? topics,
    String? imageUrl,
    DateTime? updatedAt,
    String? userId,
    String? userName,
  }) {
    print('TEST - ${userName ?? this.userName}');
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  BlogModel copyForLocal() {
    return BlogModel(
      id: id,
      title: title,
      content: content,
      topics: topics,
      imageUrl: null,
      updatedAt: updatedAt,
      userId: userId,
      userName: userName,
    );
  }
}
