import '../models/student.dart';

class StudentRepository {
  StudentRepository._();

  static final StudentRepository instance =
  StudentRepository._();

  /// Temporary in-memory data.
  /// This will be replaced by Firestore in Sprint 14.
  final List<Student> _students = [
    Student(
      id: 'S001',
      admissionNumber: 'EK001',
      firstName: 'Aryan',
      lastName: 'Bhagwat',
      dateOfBirth: DateTime(2022, 4, 15),
      gender: 'Male',
      classroomId: 'NURSERY',
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

    if (index == -1) return;

    _students[index] = updatedStudent;
  }

  void removeStudent(String id) {
    _students.removeWhere(
          (student) => student.id == id,
    );
  }

  void clear() {
    _students.clear();
  }

  int get totalStudents => _students.length;

  int get totalDaycareStudents =>
      daycareStudents.length;

  int get totalActiveStudents =>
      activeStudents.length;
}