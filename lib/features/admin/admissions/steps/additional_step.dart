import 'package:flutter/material.dart';

import '../../../../models/admission_draft.dart';

class AdditionalStep extends StatefulWidget {
  final AdmissionDraft draft;

  const AdditionalStep({
    super.key,
    required this.draft,
  });

  @override
  State<AdditionalStep> createState() => _AdditionalStepState();
}

class _AdditionalStepState extends State<AdditionalStep> {
  late final TextEditingController _medicalController;
  late final TextEditingController _allergyController;

  @override
  void initState() {
    super.initState();

    _medicalController = TextEditingController(
      text: widget.draft.medicalNotes,
    );

    _allergyController = TextEditingController(
      text: widget.draft.allergies,
    );
  }

  @override
  void dispose() {
    _medicalController.dispose();
    _allergyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: SwitchListTile(
            value: widget.draft.daycare,
            title: const Text("Daycare Required"),
            subtitle: const Text("Enroll this child in daycare"),
            secondary: const Icon(Icons.child_care),
            onChanged: (value) {
              setState(() {
                widget.draft.daycare = value;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        Card(
          child: SwitchListTile(
            value: widget.draft.transport,
            title: const Text("Transport Required"),
            subtitle: const Text("School transport required"),
            secondary: const Icon(Icons.directions_bus),
            onChanged: (value) {
              setState(() {
                widget.draft.transport = value;
              });
            },
          ),
        ),

        const SizedBox(height: 24),

        TextField(
          controller: _allergyController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Allergies",
            hintText: "Mention food, medicine or other allergies",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.draft.allergies = value;
          },
        ),

        const SizedBox(height: 16),

        TextField(
          controller: _medicalController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: "Medical Notes",
            hintText: "Medical conditions, medications or special instructions",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.draft.medicalNotes = value;
          },
        ),
      ],
    );
  }
}