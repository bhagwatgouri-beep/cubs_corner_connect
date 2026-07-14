import 'package:flutter/material.dart';

import '../../../models/student.dart';

class StudentProfileScreen extends StatelessWidget {
  final Student student;

  const StudentProfileScreen({
    super.key,
    required this.student,
  });

  Widget _infoTile(
      IconData icon,
      String title,
      String value,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value.isEmpty ? "-" : value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dob =
        "${student.dateOfBirth.day.toString().padLeft(2, '0')}/"
        "${student.dateOfBirth.month.toString().padLeft(2, '0')}/"
        "${student.dateOfBirth.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text(student.fullName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      student.firstName.isEmpty
                          ? "?"
                          : student.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    student.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(student.admissionNumber),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _infoTile(Icons.cake, "Date of Birth", dob),
                _infoTile(Icons.person, "Gender", student.gender),
                _infoTile(Icons.class_, "Class", student.classroomId),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: student.isDaycareEnrolled,
                  onChanged: null,
                  title: const Text("Daycare"),
                ),
                SwitchListTile(
                  value: student.usesTransport,
                  onChanged: null,
                  title: const Text("Transport"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _infoTile(
                  Icons.medical_information,
                  "Medical Notes",
                  student.medicalNotes,
                ),
                _infoTile(
                  Icons.warning_amber,
                  "Allergies",
                  student.allergies,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // ADM-004B
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"),
      ),
    );
  }
}
