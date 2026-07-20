import '../models/announcement.dart';

class CommunicationRepository {
  CommunicationRepository._();

  static final CommunicationRepository instance =
  CommunicationRepository._();

  final List<Announcement> _announcements = [];

  List<Announcement> get announcements =>
      List.unmodifiable(_announcements);

  List<Announcement> get publishedAnnouncements =>
      _announcements
          .where((announcement) => announcement.isPublished)
          .toList();

  List<Announcement> get draftAnnouncements =>
      _announcements
          .where((announcement) => !announcement.isPublished)
          .toList();

  void saveAnnouncement(Announcement announcement) {
    _announcements.removeWhere(
          (a) => a.id == announcement.id,
    );
    _announcements.add(announcement);
  }

  void saveAnnouncements(
      List<Announcement> announcements,
      ) {
    for (final announcement in announcements) {
      saveAnnouncement(announcement);
    }
  }

  Announcement? getAnnouncement(String id) {
    try {
      return _announcements.firstWhere(
            (a) => a.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  List<Announcement> announcementsForAudience(
      String audience,
      ) {
    return _announcements
        .where((a) => a.audience == audience)
        .toList();
  }

  void deleteAnnouncement(String id) {
    _announcements.removeWhere(
          (a) => a.id == id,
    );
  }

  int totalAnnouncements() =>
      _announcements.length;

  int totalPublished() =>
      publishedAnnouncements.length;

  int totalDrafts() =>
      draftAnnouncements.length;

  void clear() {
    _announcements.clear();
  }
}