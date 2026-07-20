import '../models/teacher.dart';

class TeacherRepository {
  TeacherRepository._();

  static final TeacherRepository instance = TeacherRepository._();

  final List<Teacher> _teachers = [];

  List<Teacher> get teachers => List.unmodifiable(_teachers);

  List<Teacher> get activeTeachers =>
      _teachers.where((teacher) => teacher.isActive).toList();

  List<Teacher> get inactiveTeachers =>
      _teachers.where((teacher) => !teacher.isActive).toList();

  void saveTeacher(Teacher teacher) {
    _teachers.removeWhere((t) => t.id == teacher.id);
    _teachers.add(teacher);
  }

  void saveTeachers(List<Teacher> teachers) {
    for (final teacher in teachers) {
      saveTeacher(teacher);
    }
  }

  Teacher? getTeacher(String id) {
    try {
      return _teachers.firstWhere(
            (teacher) => teacher.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Teacher? getTeacherByEmployeeCode(String employeeCode) {
    try {
      return _teachers.firstWhere(
            (teacher) =>
        teacher.employeeCode.toLowerCase() ==
            employeeCode.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  List<Teacher> teachersByCentre(String centreId) {
    return _teachers
        .where((teacher) => teacher.centreId == centreId)
        .toList();
  }

  List<Teacher> teachersByRole(String role) {
    return _teachers
        .where((teacher) => teacher.role == role)
        .toList();
  }

  List<Teacher> teachersByClassroom(String classroomId) {
    return _teachers
        .where(
          (teacher) =>
          teacher.classroomIds.contains(classroomId),
    )
        .toList();
  }

  void deleteTeacher(String id) {
    _teachers.removeWhere(
          (teacher) => teacher.id == id,
    );
  }

  bool teacherExists(String id) {
    return _teachers.any(
          (teacher) => teacher.id == id,
    );
  }

  int totalTeachers() {
    return _teachers.length;
  }

  int totalActiveTeachers() {
    return activeTeachers.length;
  }

  int totalInactiveTeachers() {
    return inactiveTeachers.length;
  }

  void clear() {
    _teachers.clear();
  }
}