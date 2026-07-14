import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/parent.dart';

class ParentRepository {
  ParentRepository._({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static final ParentRepository instance = ParentRepository._();

  final FirebaseFirestore _firestore;

  /// Temporary in-memory list.
  final List<Parent> _parents = [];

  CollectionReference<Map<String, dynamic>> get _parentCollection =>
      _firestore.collection('parents');

  // ------------------------
  // CURRENT APP (In-memory)
  // ------------------------

  List<Parent> get parents => List.unmodifiable(_parents);

  Parent? getParent(String id) {
    try {
      return _parents.firstWhere(
            (parent) => parent.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Parent? getByMobile(String mobile) {
    try {
      return _parents.firstWhere(
            (parent) =>
        parent.mobileNumber.trim() == mobile.trim(),
      );
    } catch (_) {
      return null;
    }
  }

  Parent? getByEmail(String email) {
    try {
      return _parents.firstWhere(
            (parent) =>
        parent.email.toLowerCase().trim() ==
            email.toLowerCase().trim(),
      );
    } catch (_) {
      return null;
    }
  }

  bool mobileExists(String mobile) {
    return getByMobile(mobile) != null;
  }

  bool emailExists(String email) {
    return getByEmail(email) != null;
  }

  void addParent(Parent parent) {
    _parents.add(parent);
  }

  void updateParent(Parent updatedParent) {
    final index = _parents.indexWhere(
          (parent) => parent.id == updatedParent.id,
    );

    if (index != -1) {
      _parents[index] = updatedParent;
    }
  }

  void removeParent(String id) {
    _parents.removeWhere(
          (parent) => parent.id == id,
    );
  }

  int get totalParents => _parents.length;

  // ------------------------
  // FUTURE FIRESTORE METHODS
  // ------------------------

  Future<List<Parent>> fetchParents() async {
    final snapshot = await _parentCollection.get();

    return snapshot.docs
        .map(
          (doc) => Parent.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }

  Future<void> saveParent(Parent parent) async {
    await _parentCollection
        .doc(parent.id)
        .set(parent.toMap());
  }

  Future<void> deleteParentFromFirestore(
      String id,
      ) async {
    await _parentCollection.doc(id).delete();
  }
}