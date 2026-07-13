import '../models/student.dart';

class StudentRepository {
  StudentRepository._();

  static final StudentRepository instance =
  StudentRepository._();

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
      parentIds: ['P001'],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: true,
      usesTransport: false,
      pickupPersons: ['Mother', 'Father'],
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
      parentIds: ['P002'],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: true,
      usesTransport: true,
      pickupPersons: ['Grandmother'],
      medicalNotes: '',
      allergies: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<Student> get allStudents =>
      List.unmodifiable(_students);

  List<Student> get daycareStudents =>
      _students
          .where((student) => student.isDaycareEnrolled)
          .toList();

  Student? getById(String id) {
    try {
      return _students.firstWhere(
            (student) => student.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}