import '../models/memory.dart';

class LocalMemoryStore {
  LocalMemoryStore._();

  static final LocalMemoryStore instance = LocalMemoryStore._();

  final List<MemoryRecord> _memories = [];

  List<MemoryRecord> get memories => List.unmodifiable(_memories);

  void save(MemoryRecord memory) {
    _memories.insert(0, memory);
  }

  int get count => _memories.length;
}
