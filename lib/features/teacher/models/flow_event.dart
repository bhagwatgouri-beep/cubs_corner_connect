class FlowEvent {
  final String title;
  final String emoji;
  final List<String> menuItems;
  final bool supportsExceptions;
  final String completionMessage;

  const FlowEvent({
    required this.title,
    required this.emoji,
    required this.menuItems,
    required this.supportsExceptions,
    required this.completionMessage,
  });

  static const List<FlowEvent> dailyEvents = [
    FlowEvent(
      title: 'Breakfast',
      emoji: '🍎',
      menuItems: ['Milk', 'Poha', 'Banana'],
      supportsExceptions: true,
      completionMessage: 'Breakfast Completed',
    ),
    FlowEvent(
      title: 'Lunch',
      emoji: '🍛',
      menuItems: ['Chapati', 'Dal', 'Rice'],
      supportsExceptions: true,
      completionMessage: 'Lunch Completed',
    ),
    FlowEvent(
      title: 'Nap',
      emoji: '😴',
      menuItems: [],
      supportsExceptions: false,
      completionMessage: 'Nap Time Recorded',
    ),
    FlowEvent(
      title: 'Snack',
      emoji: '🍌',
      menuItems: ['Fruit', 'Milk'],
      supportsExceptions: true,
      completionMessage: 'Snack Completed',
    ),
  ];
}
