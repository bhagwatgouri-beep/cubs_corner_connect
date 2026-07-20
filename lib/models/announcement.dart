class Announcement {
  final String id;

  final String title;

  final String message;

  final String audience;

  final DateTime createdAt;

  final String createdBy;

  final bool isPublished;

  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.audience,
    required this.createdAt,
    required this.createdBy,
    this.isPublished = true,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? message,
    String? audience,
    DateTime? createdAt,
    String? createdBy,
    bool? isPublished,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      audience: audience ?? this.audience,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      isPublished: isPublished ?? this.isPublished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'audience': audience,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'isPublished': isPublished,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      audience: map['audience'] ?? '',
      createdAt: DateTime.tryParse(
        map['createdAt'] ?? '',
      ) ??
          DateTime.now(),
      createdBy: map['createdBy'] ?? '',
      isPublished: map['isPublished'] ?? true,
    );
  }
}