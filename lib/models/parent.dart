class Parent {
  final String id;

  final String firstName;
  final String lastName;

  final String mobileNumber;
  final String email;

  final String relationship;

  final String occupation;

  final String address;

  final bool isPrimaryContact;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Parent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.relationship,
    required this.occupation,
    required this.address,
    required this.isPrimaryContact,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => "$firstName $lastName";

  Parent copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? email,
    String? relationship,
    String? occupation,
    String? address,
    bool? isPrimaryContact,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Parent(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      relationship: relationship ?? this.relationship,
      occupation: occupation ?? this.occupation,
      address: address ?? this.address,
      isPrimaryContact:
      isPrimaryContact ?? this.isPrimaryContact,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Parent.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return Parent(
      id: id,
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      mobileNumber: map["mobileNumber"] ?? "",
      email: map["email"] ?? "",
      relationship: map["relationship"] ?? "",
      occupation: map["occupation"] ?? "",
      address: map["address"] ?? "",
      isPrimaryContact:
      map["isPrimaryContact"] ?? true,
      createdAt: DateTime.tryParse(
        map["createdAt"] ?? "",
      ) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
        map["updatedAt"] ?? "",
      ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "mobileNumber": mobileNumber,
      "email": email,
      "relationship": relationship,
      "occupation": occupation,
      "address": address,
      "isPrimaryContact": isPrimaryContact,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Parent && other.id == id;

  @override
  int get hashCode => id.hashCode;
}