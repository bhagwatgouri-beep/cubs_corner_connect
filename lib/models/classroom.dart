class Classroom {
  final String id;

  final String name;

  final String ageGroup;

  final String centreId;

  final List<String> teacherIds;

  final int capacity;

  final bool isActive;

  const Classroom({
    required this.id,
    required this.name,
    required this.ageGroup,
    required this.centreId,
    required this.teacherIds,
    required this.capacity,
    this.isActive = true,
  });
}