class ParentStoryItem {
  final String id;
  final DateTime time;
  final String emoji;
  final String title;
  final String description;
  final String sourceEvent;

  const ParentStoryItem({
    required this.id,
    required this.time,
    required this.emoji,
    required this.title,
    required this.description,
    required this.sourceEvent,
  });

  ParentStoryItem copyWith({
    String? id,
    DateTime? time,
    String? emoji,
    String? title,
    String? description,
    String? sourceEvent,
  }) {
    return ParentStoryItem(
      id: id ?? this.id,
      time: time ?? this.time,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      description: description ?? this.description,
      sourceEvent: sourceEvent ?? this.sourceEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'emoji': emoji,
      'title': title,
      'description': description,
      'sourceEvent': sourceEvent,
    };
  }

  factory ParentStoryItem.fromMap(Map<String, dynamic> map) {
    return ParentStoryItem(
      id: map['id'] as String,
      time: DateTime.parse(map['time'] as String),
      emoji: map['emoji'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      sourceEvent: map['sourceEvent'] as String,
    );
  }

  @override
  String toString() {
    return 'ParentStoryItem(id: $id, time: $time, emoji: $emoji, '
        'title: $title, description: $description, '
        'sourceEvent: $sourceEvent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ParentStoryItem &&
        other.id == id &&
        other.time == time &&
        other.emoji == emoji &&
        other.title == title &&
        other.description == description &&
        other.sourceEvent == sourceEvent;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      time,
      emoji,
      title,
      description,
      sourceEvent,
    );
  }
}
