class Parent {
  final String id;

  final String fatherName;
  final String motherName;

  final String mobile1;
  final String? mobile2;

  final String? email;

  final String address;

  final String emergencyContactName;
  final String emergencyContactNumber;

  final List<String> studentIds;

  final bool isActive;

  const Parent({
    required this.id,
    required this.fatherName,
    required this.motherName,
    required this.mobile1,
    this.mobile2,
    this.email,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.studentIds,
    this.isActive = true,
  });
}