class DaycareChild {
  final String id;
  final String name;
  final String classroom;
  final bool isEnrolled;
  final String? parentId;

  const DaycareChild({
    required this.id,
    required this.name,
    required this.classroom,
    required this.isEnrolled,
    this.parentId,
  });

  DaycareChild copyWith({
    String? id,
    String? name,
    String? classroom,
    bool? isEnrolled,
    String? parentId,
  }) {
    return DaycareChild(
      id: id ?? this.id,
      name: name ?? this.name,
      classroom: classroom ?? this.classroom,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      parentId: parentId ?? this.parentId,
    );
  }
}