import 'package:blog_app/feature/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.topics,
    required super.imageUrl,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        id: json["id"] as String,
        posterId: json["poster_id"] as String,
        title: json["title"] as String,
        content: json["content"] as String,
        imageUrl: json["image_url"] as String,
        topics: List<String>.from(json["topics"] ?? []),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_id": posterId,
        "title": title,
        "content": content,
        "image_url": imageUrl,
        "topics": topics,
        "updated_at": updatedAt.toIso8601String(),
      };

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    List<String>? topics,
    String? imageUrl,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
