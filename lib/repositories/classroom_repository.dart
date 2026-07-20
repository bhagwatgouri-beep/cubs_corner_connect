import '../models/classroom.dart';

class ClassroomRepository {
  ClassroomRepository._();

  static final ClassroomRepository instance =
  ClassroomRepository._();

  final List<Classroom> _classrooms = [];

  List<Classroom> get classrooms =>
      List.unmodifiable(_classrooms);

  List<Classroom> get activeClassrooms =>
      _classrooms.where((c) => c.isActive).toList();

  List<Classroom> get inactiveClassrooms =>
      _classrooms.where((c) => !c.isActive).toList();

  void saveClassroom(Classroom classroom) {
    _classrooms.removeWhere((c) => c.id == classroom.id);
    _classrooms.add(classroom);
  }

  void saveClassrooms(List<Classroom> classrooms) {
    for (final classroom in classrooms) {
      saveClassroom(classroom);
    }
  }

  Classroom? getClassroom(String id) {
    try {
      return _classrooms.firstWhere(
            (c) => c.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Classroom? getByCode(String code) {
    try {
      return _classrooms.firstWhere(
            (c) => c.code.toLowerCase() ==
            code.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  List<Classroom> byCentre(String centreId) {
    return _classrooms
        .where((c) => c.centreId == centreId)
        .toList();
  }

  void deleteClassroom(String id) {
    _classrooms.removeWhere((c) => c.id == id);
  }

  int totalClassrooms() => _classrooms.length;

  int totalActiveClassrooms() =>
      activeClassrooms.length;

  int totalInactiveClassrooms() =>
      inactiveClassrooms.length;

  void clear() {
    _classrooms.clear();
  }
}