enum MemoryAudience {
  entireClass,
  selectedChildren,
}

class CapturedMemoryPhoto {
  final String id;
  final DateTime capturedAt;

  const CapturedMemoryPhoto({
    required this.id,
    required this.capturedAt,
  });
}

class MemoryRecord {
  final String id;
  final List<CapturedMemoryPhoto> photos;
  final MemoryAudience audience;
  final List<String> selectedChildren;
  final DateTime createdAt;

  const MemoryRecord({
    required this.id,
    required this.photos,
    required this.audience,
    required this.selectedChildren,
    required this.createdAt,
  });

  bool get isForEntireClass => audience == MemoryAudience.entireClass;
}
