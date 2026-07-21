class AdmissionDraft {
  // Student
  String studentId = '';

  String admissionNumber = '';
  String firstName = '';
  String lastName = '';
  DateTime? dateOfBirth;
  String gender = '';

  /// Local image selected during admission.
  /// Later this will hold the Firebase Storage URL.
  String profileImageUrl = '';

  // Guardian 1
  String guardian1Name = '';
  String guardian1Relationship = '';
  String guardian1Mobile = '';
  String guardian1Email = '';

  // Linked Parent
  String parentId = '';

  // Guardian 2
  String guardian2Name = '';
  String guardian2Relationship = '';
  String guardian2Mobile = '';
  String guardian2Email = '';

  // School
  bool daycare = false;
  bool transport = false;

  String classroomId = 'Daycare';
  String centreId = 'CENTRE01';

  // Health
  String allergies = '';
  String medicalNotes = '';

  bool get isEdit => studentId.isNotEmpty;
}