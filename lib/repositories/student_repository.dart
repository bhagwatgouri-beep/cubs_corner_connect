import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student.dart';

class StudentRepository {
  StudentRepository._({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static final StudentRepository instance =
  StudentRepository._();

  final FirebaseFirestore _firestore;

  /// Temporary in-memory list.
  /// This will be removed after the Admin module starts
  /// saving students into Firestore.
  final List<Student> _students = [
    Student(
      id: 'S001',
      admissionNumber: 'EK001',
      firstName: 'Aryan',
      lastName: 'Bhagwat',
      dateOfBirth: DateTime(2022, 4, 15),
      gender: 'Male',
      classroomId: 'Nursery',
      centreId: 'CENTRE01',
      parentIds: const ['P001'],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: true,
      usesTransport: false,
      pickupPersons: const [
        'Mother',
        'Father',
      ],
      medicalNotes: '',
      allergies: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Student(
      id: 'S002',
      admissionNumber: 'EK002',
      firstName: 'Ira',
      lastName: 'Patil',
      dateOfBirth: DateTime(2021, 11, 10),
      gender: 'Female',
      classroomId: 'KG1',
      centreId: 'CENTRE01',
      parentIds: const ['P002'],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: true,
      usesTransport: true,
      pickupPersons: const [
        'Grandmother',
      ],
      medicalNotes: '',
      allergies: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  CollectionReference<Map<String, dynamic>> get _studentCollection =>
      _firestore.collection('students');

  // ------------------------
  // CURRENT APP (In-memory)
  // ------------------------

  List<Student> get students =>
      List.unmodifiable(_students);

  List<Student> get activeStudents =>
      _students.where((s) => s.isActive).toList();

  List<Student> get daycareStudents =>
      _students.where((s) => s.isDaycareEnrolled).toList();

  Student? getStudent(String id) {
    try {
      return _students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void addStudent(Student student) {
    _students.add(student);
  }

  void updateStudent(Student updatedStudent) {
    final index = _students.indexWhere(
          (student) => student.id == updatedStudent.id,
    );

    if (index != -1) {
      _students[index] = updatedStudent;
    }
  }

  void removeStudent(String id) {
    _students.removeWhere(
          (student) => student.id == id,
    );
  }

  int get totalStudents => _students.length;

  // ------------------------
  // FUTURE FIRESTORE METHODS
  // ------------------------

  Future<List<Student>> fetchStudents() async {
    final snapshot = await _studentCollection.get();

    return snapshot.docs
        .map(
          (doc) => Student.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }

  Future<void> saveStudent(Student student) async {
    await _studentCollection
        .doc(student.id)
        .set(student.toMap());
  }

  Future<void> deleteStudentFromFirestore(
      String id,
      ) async {
    await _studentCollection.doc(id).delete();
  }
}