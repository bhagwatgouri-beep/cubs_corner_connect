class Classroom {
  final String id;

  final String code;

  final String name;

  final String ageGroup;

  final String section;

  final String centreId;

  final List<String> teacherIds;

  final int capacity;

  final int currentStrength;

  final String roomNumber;

  final String remarks;

  final bool isActive;

  const Classroom({
    required this.id,
    required this.code,
    required this.name,
    required this.ageGroup,
    required this.section,
    required this.centreId,
    required this.teacherIds,
    required this.capacity,
    this.currentStrength = 0,
    this.roomNumber = '',
    this.remarks = '',
    this.isActive = true,
  });

  Classroom copyWith({
    String? id,
    String? code,
    String? name,
    String? ageGroup,
    String? section,
    String? centreId,
    List<String>? teacherIds,
    int? capacity,
    int? currentStrength,
    String? roomNumber,
    String? remarks,
    bool? isActive,
  }) {
    return Classroom(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      ageGroup: ageGroup ?? this.ageGroup,
      section: section ?? this.section,
      centreId: centreId ?? this.centreId,
      teacherIds: teacherIds ?? this.teacherIds,
      capacity: capacity ?? this.capacity,
      currentStrength: currentStrength ?? this.currentStrength,
      roomNumber: roomNumber ?? this.roomNumber,
      remarks: remarks ?? this.remarks,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'ageGroup': ageGroup,
      'section': section,
      'centreId': centreId,
      'teacherIds': teacherIds,
      'capacity': capacity,
      'currentStrength': currentStrength,
      'roomNumber': roomNumber,
      'remarks': remarks,
      'isActive': isActive,
    };
  }

  factory Classroom.fromMap(Map<String, dynamic> map) {
    return Classroom(
      id: map['id'] ?? '',
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      ageGroup: map['ageGroup'] ?? '',
      section: map['section'] ?? '',
      centreId: map['centreId'] ?? '',
      teacherIds: List<String>.from(map['teacherIds'] ?? const []),
      capacity: map['capacity'] ?? 0,
      currentStrength: map['currentStrength'] ?? 0,
      roomNumber: map['roomNumber'] ?? '',
      remarks: map['remarks'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }
}