import '../models/daycare_child.dart';

class DaycareChildRepository {
  DaycareChildRepository._();

  static final DaycareChildRepository instance =
  DaycareChildRepository._();

  final List<DaycareChild> _children = [
    DaycareChild(
      id: 'C001',
      name: 'Aryan Bhagwat',
      classroom: 'Nursery',
      isEnrolled: true,
      parentId: 'P001',
    ),
    DaycareChild(
      id: 'C002',
      name: 'Aarav Sharma',
      classroom: 'KG1',
      isEnrolled: true,
      parentId: 'P002',
    ),
    DaycareChild(
      id: 'C003',
      name: 'Ira Mehta',
      classroom: 'KG2',
      isEnrolled: false,
      parentId: 'P003',
    ),
    DaycareChild(
      id: 'C004',
      name: 'Kabir Rao',
      classroom: 'Playgroup',
      isEnrolled: true,
      parentId: 'P004',
    ),
  ];

  List<DaycareChild> get allChildren =>
      List.unmodifiable(_children);

  List<DaycareChild> get enrolledChildren =>
      _children.where((child) => child.isEnrolled).toList();

  DaycareChild? getById(String id) {
    try {
      return _children.firstWhere((child) => child.id == id);
    } catch (_) {
      return null;
    }
  }

  void addChild(DaycareChild child) {
    _children.add(child);
  }

  void updateChild(DaycareChild updatedChild) {
    final index =
    _children.indexWhere((c) => c.id == updatedChild.id);

    if (index != -1) {
      _children[index] = updatedChild;
    }
  }

  void removeChild(String id) {
    _children.removeWhere((child) => child.id == id);
  }

  void clear() {
    _children.clear();
  }

  int get enrolledCount => enrolledChildren.length;
}