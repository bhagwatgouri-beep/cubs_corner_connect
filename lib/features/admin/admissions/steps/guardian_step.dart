import 'package:flutter/material.dart';

import '../../../../models/admission_draft.dart';
import '../../../../models/parent.dart';
import '../../../../repositories/parent_repository.dart';

enum _ParentSelectionType {
  existing,
  newParent,
}

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

  _ParentSelectionType _selectionType = _ParentSelectionType.newParent;
  List<Parent> _matchingParents = [];
  bool _isSearching = false;

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

  Future<void> _searchParents(String mobile) async {
    final query = mobile.trim();

    if (query.isEmpty) {
      setState(() {
        _matchingParents = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final parents = <Parent>[
      ...ParentRepository.instance.parents,
    ];

    try {
      parents.addAll(
        await ParentRepository.instance.fetchParents(),
      );
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _isSearching = false;
      _matchingParents = parents
          .where((parent) => parent.mobileNumber.contains(query))
          .toSet()
          .toList();
    });
  }

  void _selectParent(Parent parent) {
    setState(() {
      widget.draft.parentId = parent.id;
      widget.draft.guardian1Name = parent.fullName.trim();
      widget.draft.guardian1Relationship = parent.relationship;
      widget.draft.guardian1Mobile = parent.mobileNumber;
      widget.draft.guardian1Email = parent.email;
    });
  }

  void _selectNewParent() {
    setState(() {
      _selectionType = _ParentSelectionType.newParent;
      widget.draft.parentId = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RadioListTile<_ParentSelectionType>(
            value: _ParentSelectionType.existing,
            groupValue: _selectionType,
            title: const Text("Existing Parent"),
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _selectionType = value;
                widget.draft.parentId = '';
              });
            },
          ),
          RadioListTile<_ParentSelectionType>(
            value: _ParentSelectionType.newParent,
            groupValue: _selectionType,
            title: const Text("New Parent"),
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              if (value == null) return;

              _selectNewParent();
            },
          ),

          const SizedBox(height: 16),

          if (_selectionType == _ParentSelectionType.existing) ...[
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Search by Mobile Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchParents,
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_matchingParents.isNotEmpty)
              ..._matchingParents.map(
                (parent) => Card(
                  child: RadioListTile<String>(
                    value: parent.id,
                    groupValue: widget.draft.parentId,
                    title: Text(parent.fullName),
                    subtitle: Text(parent.mobileNumber),
                    onChanged: (_) => _selectParent(parent),
                  ),
                ),
              )
            else
              const Text("No matching parents found"),
            FormField<String>(
              initialValue: widget.draft.parentId,
              validator: (_) {
                if (widget.draft.parentId.isEmpty) {
                  return "Select an existing parent";
                }
                return null;
              },
              builder: (field) {
                if (!field.hasError) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    field.errorText!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              },
            ),
          ] else ...[
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
            widget.draft.parentId = '';
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
            widget.draft.parentId = '';
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
            widget.draft.parentId = '';
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
            widget.draft.parentId = '';
          },
        ),
          ],
        ],
      ),
    );
  }
}
