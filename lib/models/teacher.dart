class Teacher {
  final String id;

  final String name;

  final String email;

  final String phoneNumber;

  final String role;

  final String centreId;

  final List<String> classroomIds;

  final bool isActive;

  const Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.centreId,
    required this.classroomIds,
    this.isActive = true,
  });
}