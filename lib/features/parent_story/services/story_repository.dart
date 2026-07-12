import '../models/parent_story_item.dart';

class StoryRepository {
  final List<ParentStoryItem> _items = [];

  void addStoryItem(ParentStoryItem item) {
    _items.add(item);
  }

  void removeStoryItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  List<ParentStoryItem> getAll() {
    return List.unmodifiable(_items);
  }

  void clear() {
    _items.clear();
  }

  int count() {
    return _items.length;
  }
}
