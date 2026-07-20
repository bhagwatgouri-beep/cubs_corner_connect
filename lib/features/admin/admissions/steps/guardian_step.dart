import 'package:flutter/material.dart';

import '../../../../models/admission_draft.dart';

class GuardianStep extends StatefulWidget {
  final AdmissionDraft draft;
  final GlobalKey<FormState> formKey;

  const GuardianStep({
    super.key,
    required this.draft,
    required this.formKey,
  });

  @override
  State<GuardianStep> createState() => _GuardianStepState();
}

class _GuardianStepState extends State<GuardianStep> {
  late final TextEditingController _guardian1NameController;
  late final TextEditingController _guardian1MobileController;
  late final TextEditingController _guardian1EmailController;

  @override
  void initState() {
    super.initState();

    _guardian1NameController = TextEditingController(
      text: widget.draft.guardian1Name,
    );

    _guardian1MobileController = TextEditingController(
      text: widget.draft.guardian1Mobile,
    );

    _guardian1EmailController = TextEditingController(
      text: widget.draft.guardian1Email,
    );
  }

  @override
  void dispose() {
    _guardian1NameController.dispose();
    _guardian1MobileController.dispose();
    _guardian1EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        TextFormField(
          controller: _guardian1NameController,
          decoration: const InputDecoration(
            labelText: "Guardian Name",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Guardian Name is required";
            }
            return null;
          },
          onChanged: (value) {
            widget.draft.guardian1Name = value;
          },
        ),

        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          initialValue: widget.draft.guardian1Relationship.isEmpty
              ? null
              : widget.draft.guardian1Relationship,
          decoration: const InputDecoration(
            labelText: "Relationship",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.family_restroom),
          ),
          items: const [
            DropdownMenuItem(
              value: "Mother",
              child: Text("Mother"),
            ),
            DropdownMenuItem(
              value: "Father",
              child: Text("Father"),
            ),
            DropdownMenuItem(
              value: "Grandparent",
              child: Text("Grandparent"),
            ),
            DropdownMenuItem(
              value: "Guardian",
              child: Text("Guardian"),
            ),
            DropdownMenuItem(
              value: "Other",
              child: Text("Other"),
            ),
          ],
          onChanged: (value) {
            widget.draft.guardian1Relationship = value ?? "";
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: _guardian1MobileController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: "Mobile Number",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Mobile Number is required";
            }
            return null;
          },
          onChanged: (value) {
            widget.draft.guardian1Mobile = value;
          },
        ),

        const SizedBox(height: 16),

        TextField(
          controller: _guardian1EmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Email Address",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: (value) {
            widget.draft.guardian1Email = value;
          },
        ),
        ],
      ),
    );
  }
}
