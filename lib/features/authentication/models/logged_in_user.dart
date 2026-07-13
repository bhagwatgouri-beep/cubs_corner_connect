/// Immutable, typed representation of the currently authenticated user.
///
/// This model is the in-memory shape used across the app once a user has
/// signed in and their profile has been resolved. It does not perform
/// authentication or role routing itself — it is a plain data holder,
/// typically built from [AuthService] + [UserRepository] results.
class LoggedInUser {
  const LoggedInUser({
    required this.uid,
    required this.displayName,
    required this.role,
    required this.centreId,
  });

  /// Firebase Authentication UID.
  final String uid;

  /// Name shown throughout the app for this user.
  final String displayName;

  /// One of the roles defined in Role Permissions (e.g. "superAdmin",
  /// "centreAdmin", "teacher", "parent"). Stored as a raw string so this
  /// model stays decoupled from any specific role enum implementation.
  final String role;

  /// Identifier of the centre this user belongs to.
  final String centreId;

  /// Returns a copy of this user with the given fields replaced.
  LoggedInUser copyWith({
    String? uid,
    String? displayName,
    String? role,
    String? centreId,
  }) {
    return LoggedInUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      centreId: centreId ?? this.centreId,
    );
  }

  /// Builds a [LoggedInUser] from a raw map, such as one returned by
  /// [UserRepository.getUser].
  ///
  /// Missing fields fall back to an empty string rather than throwing,
  /// keeping this constructor safe to use directly against Firestore data.
  factory LoggedInUser.fromMap(Map<String, dynamic> map) {
    return LoggedInUser(
      uid: map['uid'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      role: map['role'] as String? ?? '',
      centreId: map['centreId'] as String? ?? '',
    );
  }

  /// Converts this user into a raw map suitable for storage (e.g.
  /// Firestore) or serialization.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'role': role,
      'centreId': centreId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoggedInUser &&
        other.uid == uid &&
        other.displayName == displayName &&
        other.role == role &&
        other.centreId == centreId;
  }

  @override
  int get hashCode => Object.hash(uid, displayName, role, centreId);

  @override
  String toString() {
    return 'LoggedInUser(uid: $uid, displayName: $displayName, '
        'role: $role, centreId: $centreId)';
  }
}
