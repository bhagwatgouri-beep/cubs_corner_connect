import '../models/child.dart';

class DashboardController {
  Child getCurrentChild() {
    return const Child(
      id: '001',
      name: 'Aryan Bhagwat',
      classroom: 'Nursery',
      profileImage: '',
      checkInTime: '8:48 AM',
      present: true,
      memoriesToday: 8,
      teacherNote:
      'Aryan enjoyed Story Time today and participated enthusiastically during Finger Painting.',
      tomorrowEvent: 'Blue Colour Day 💙',
    );
  }

  List<Map<String, String>> getTodayJourney() {
    return [
      {
        'time': '8:48 AM',
        'title': 'Checked In',
        'icon': '✅',
      },
      {
        'time': '9:15 AM',
        'title': 'Breakfast',
        'icon': '🍎',
      },
      {
        'time': '10:00 AM',
        'title': 'Circle Time',
        'icon': '🎵',
      },
      {
        'time': '11:15 AM',
        'title': 'Creative Art',
        'icon': '🎨',
      },
      {
        'time': '12:30 PM',
        'title': 'Lunch',
        'icon': '🍛',
      },
    ];
  }
}