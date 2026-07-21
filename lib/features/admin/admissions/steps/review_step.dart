import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../models/admission_draft.dart';

class ReviewStep extends StatelessWidget {
  final AdmissionDraft draft;

  const ReviewStep({
    super.key,
    required this.draft,
  });

  Widget _tile(String title, String value) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? "-" : value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dob = "-";

    if (draft.dateOfBirth != null) {
      final d = draft.dateOfBirth!;
      dob = "${d.day}/${d.month}/${d.year}";
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Student Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                if (draft.profileImageUrl.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(
                      File(draft.profileImageUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                _tile("Admission No", draft.admissionNumber),
                _tile("First Name", draft.firstName),
                _tile("Last Name", draft.lastName),
                _tile("Gender", draft.gender),
                _tile("Date of Birth", dob),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Guardian Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),

                _tile("Guardian", draft.guardian1Name),
                _tile("Relationship", draft.guardian1Relationship),
                _tile("Mobile", draft.guardian1Mobile),
                _tile("Email", draft.guardian1Email),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Additional Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),

                _tile(
                  "Daycare",
                  draft.daycare ? "Yes" : "No",
                ),

                _tile(
                  "Transport",
                  draft.transport ? "Yes" : "No",
                ),

                _tile(
                  "Allergies",
                  draft.allergies,
                ),

                _tile(
                  "Medical Notes",
                  draft.medicalNotes,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        const Card(
          color: Color(0xFFE8F5E9),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Review all details. Tap SAVE on the next step to create the student record.",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}