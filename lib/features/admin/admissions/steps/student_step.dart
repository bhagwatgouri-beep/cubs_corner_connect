import 'package:flutter/material.dart';

import '../../../../models/admission_draft.dart';

class StudentStep extends StatefulWidget {
  final AdmissionDraft draft;

  const StudentStep({
    super.key,
    required this.draft,
  });

  @override
  State<StudentStep> createState() => _StudentStepState();
}

class _StudentStepState extends State<StudentStep> {
  late final TextEditingController _admissionController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();

    _admissionController = TextEditingController(
      text: widget.draft.admissionNumber,
    );

    _firstNameController = TextEditingController(
      text: widget.draft.firstName,
    );

    _lastNameController = TextEditingController(
      text: widget.draft.lastName,
    );
  }

  @override
  void dispose() {
    _admissionController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 3),
      ),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        widget.draft.dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dob = widget.draft.dateOfBirth;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _admissionController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "Admission Number",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: "First Name",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.draft.firstName = value;
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: "Last Name",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.draft.lastName = value;
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(),
          ),
          title: const Text("Date of Birth"),
          subtitle: Text(
            dob == null
                ? "Select Date"
                : "${dob.day}/${dob.month}/${dob.year}",
          ),
          trailing: const Icon(Icons.calendar_month),
          onTap: _pickDate,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: widget.draft.gender.isEmpty
              ? null
              : widget.draft.gender,
          decoration: const InputDecoration(
            labelText: "Gender",
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(
              value: "Male",
              child: Text("Male"),
            ),
            DropdownMenuItem(
              value: "Female",
              child: Text("Female"),
            ),
            DropdownMenuItem(
              value: "Other",
              child: Text("Other"),
            ),
          ],
          onChanged: (value) {
            widget.draft.gender = value ?? "";
          },
        ),
      ],
    );
  }
}