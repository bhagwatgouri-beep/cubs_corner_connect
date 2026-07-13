import 'package:cloud_firestore/cloud_firestore.dart';

/// Reads user documents from the `users` collection in Firestore.
///
/// This repository is a pure data-access layer:
/// - It does not authenticate users.
/// - It does not decide or route roles.
/// - It does not touch UI.
///
/// Callers are responsible for interpreting the returned map (e.g. reading
/// a `role` field) and acting on it.
class UserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collectionPath = 'users';

  final FirebaseFirestore _firestore;

  /// Returns the user document for [uid] as a raw map, or `null` if no
  /// document exists for that UID.
  ///
  /// [uid] is expected to be the Firebase Authentication UID, and by
  /// convention is also the document ID within the `users` collection.
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final snapshot =
        await _firestore.collection(_collectionPath).doc(uid).get();

    if (!snapshot.exists) {
      return null;
    }

    return snapshot.data();
  }
}
