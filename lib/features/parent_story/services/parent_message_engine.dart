import '../models/parent_story_item.dart';

class ParentMessageEngine {
  ParentStoryItem generateStoryItem({
    required String eventName,
    required DateTime time,
  }) {
    final message = _messageFor(eventName);

    return ParentStoryItem(
      id: '${eventName.toLowerCase()}-${time.microsecondsSinceEpoch}',
      time: time,
      emoji: message.emoji,
      title: message.title,
      description: message.description,
      sourceEvent: eventName,
    );
  }

  _ParentStoryMessage _messageFor(String eventName) {
    switch (eventName.trim().toLowerCase()) {
      case 'arrival':
        return const _ParentStoryMessage(
          emoji: '🟢',
          title: 'Arrived Safely',
          description: 'Arrived safely at daycare.',
        );
      case 'breakfast':
        return const _ParentStoryMessage(
          emoji: '🍎',
          title: 'Enjoyed Breakfast',
          description: 'Enjoyed breakfast.',
        );
      case 'lunch':
        return const _ParentStoryMessage(
          emoji: '🍛',
          title: 'Enjoyed Lunch',
          description: 'Enjoyed lunch.',
        );
      case 'snack':
        return const _ParentStoryMessage(
          emoji: '🍌',
          title: 'Enjoyed Snack',
          description: 'Enjoyed snack.',
        );
      case 'nap':
        return const _ParentStoryMessage(
          emoji: '😴',
          title: 'Rested During Nap Time',
          description: 'Rested during nap time.',
        );
      case 'memory':
        return const _ParentStoryMessage(
          emoji: '📷',
          title: 'New Memories',
          description: "New photos from today's activities have been added.",
        );
      default:
        return const _ParentStoryMessage(
          emoji: '📌',
          title: 'Update',
          description: 'New classroom update.',
        );
    }
  }
}

class _ParentStoryMessage {
  final String emoji;
  final String title;
  final String description;

  const _ParentStoryMessage({
    required this.emoji,
    required this.title,
    required this.description,
  });
}
