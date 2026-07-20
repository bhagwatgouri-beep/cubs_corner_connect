class Teacher {
  final String id;

  final String employeeCode;

  final String name;

  final String email;

  final String phoneNumber;

  final String role;

  final String designation;

  final String qualification;

  final DateTime? dateOfBirth;

  final DateTime? joiningDate;

  final String address;

  final String remarks;

  final String photoUrl;

  final String centreId;

  final List<String> classroomIds;

  final bool isActive;

  const Teacher({
    required this.id,
    required this.employeeCode,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.designation,
    required this.qualification,
    this.dateOfBirth,
    this.joiningDate,
    this.address = '',
    this.remarks = '',
    this.photoUrl = '',
    required this.centreId,
    required this.classroomIds,
    this.isActive = true,
  });

  Teacher copyWith({
    String? id,
    String? employeeCode,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? designation,
    String? qualification,
    DateTime? dateOfBirth,
    DateTime? joiningDate,
    String? address,
    String? remarks,
    String? photoUrl,
    String? centreId,
    List<String>? classroomIds,
    bool? isActive,
  }) {
    return Teacher(
      id: id ?? this.id,
      employeeCode: employeeCode ?? this.employeeCode,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      designation: designation ?? this.designation,
      qualification: qualification ?? this.qualification,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      joiningDate: joiningDate ?? this.joiningDate,
      address: address ?? this.address,
      remarks: remarks ?? this.remarks,
      photoUrl: photoUrl ?? this.photoUrl,
      centreId: centreId ?? this.centreId,
      classroomIds: classroomIds ?? this.classroomIds,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeCode': employeeCode,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'designation': designation,
      'qualification': qualification,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'joiningDate': joiningDate?.toIso8601String(),
      'address': address,
      'remarks': remarks,
      'photoUrl': photoUrl,
      'centreId': centreId,
      'classroomIds': classroomIds,
      'isActive': isActive,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'] ?? '',
      employeeCode: map['employeeCode'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: map['role'] ?? '',
      designation: map['designation'] ?? '',
      qualification: map['qualification'] ?? '',
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.tryParse(map['dateOfBirth'])
          : null,
      joiningDate: map['joiningDate'] != null
          ? DateTime.tryParse(map['joiningDate'])
          : null,
      address: map['address'] ?? '',
      remarks: map['remarks'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      centreId: map['centreId'] ?? '',
      classroomIds:
      List<String>.from(map['classroomIds'] ?? const []),
      isActive: map['isActive'] ?? true,
    );
  }
}