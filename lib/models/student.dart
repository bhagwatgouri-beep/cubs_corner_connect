class Student {
  final String id;
  final String admissionNumber;

  final String firstName;
  final String lastName;

  final DateTime dateOfBirth;
  final String gender;

  final String classroomId;
  final String centreId;

  final List<String> parentIds;

  final String profileImageUrl;

  final bool isActive;
  final bool isDaycareEnrolled;
  final bool usesTransport;

  final List<String> pickupPersons;

  final String medicalNotes;
  final String allergies;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Student({
    required this.id,
    required this.admissionNumber,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.classroomId,
    required this.centreId,
    required this.parentIds,
    required this.profileImageUrl,
    required this.isActive,
    required this.isDaycareEnrolled,
    required this.usesTransport,
    required this.pickupPersons,
    required this.medicalNotes,
    required this.allergies,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';
}