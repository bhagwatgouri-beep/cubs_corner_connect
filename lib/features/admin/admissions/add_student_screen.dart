import 'package:flutter/material.dart';

import '../../../models/admission_draft.dart';
import '../../../models/parent.dart';
import '../../../models/student.dart';
import '../../../repositories/parent_repository.dart';
import '../../../repositories/student_repository.dart';
import 'steps/additional_step.dart';
import 'steps/guardian_step.dart';
import 'steps/review_step.dart';
import 'steps/student_step.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _studentFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _guardianFormKey = GlobalKey<FormState>();

  final AdmissionDraft draft = AdmissionDraft();

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();

    final next = StudentRepository.instance.students.length + 1;

    draft.admissionNumber =
    "SEF26${next.toString().padLeft(4, '0')}";
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_currentStep >= 3) return;

    if (_currentStep == 0 && !_studentFormKey.currentState!.validate()) {
      return;
    }

    if (_currentStep == 1 && !_guardianFormKey.currentState!.validate()) {
      return;
    }

    if (_currentStep == 1 && !await _createParentIfNeeded()) {
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    setState(() {
      _currentStep++;
    });
  }

  Future<bool> _createParentIfNeeded() async {
    if (draft.parentId.isNotEmpty) return true;

    final existingParents = <Parent>[
      ...ParentRepository.instance.parents,
    ];

    try {
      existingParents.addAll(
        await ParentRepository.instance.fetchParents(),
      );
    } catch (_) {}
    final mobileNumber = draft.guardian1Mobile.trim();

    final hasDuplicate = ParentRepository.instance.mobileExists(mobileNumber) ||
        existingParents.any(
          (parent) => parent.mobileNumber.trim() == mobileNumber,
        );

    if (hasDuplicate) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "A parent with this mobile number already exists. Select the existing parent instead.",
            ),
          ),
        );
      }
      return false;
    }

    final parent = Parent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: draft.guardian1Name.trim(),
      lastName: '',
      mobileNumber: mobileNumber,
      email: draft.guardian1Email.trim(),
      relationship: draft.guardian1Relationship,
      occupation: '',
      address: '',
      isPrimaryContact: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    ParentRepository.instance.addParent(parent);
    await ParentRepository.instance.saveParent(parent);
    draft.parentId = parent.id;

    return true;
  }

  void _back() {
    if (_currentStep == 0) {
      Navigator.pop(context);
      return;
    }

    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    setState(() {
      _currentStep--;
    });
  }

  Future<void> _save() async {
    final student = Student(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      admissionNumber: draft.admissionNumber,
      firstName: draft.firstName,
      lastName: draft.lastName,
      dateOfBirth: draft.dateOfBirth ?? DateTime.now(),
      gender: draft.gender,
      classroomId: draft.classroomId,
      centreId: draft.centreId,
      parentIds: [draft.parentId],
      profileImageUrl: '',
      isActive: true,
      isDaycareEnrolled: draft.daycare,
      usesTransport: draft.transport,
      pickupPersons: const [],
      medicalNotes: draft.medicalNotes,
      allergies: draft.allergies,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    StudentRepository.instance.addStudent(student);

    await StudentRepository.instance.saveStudent(student);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final titles = const [
      "Student Details",
      "Parent / Guardian",
      "Additional Details",
      "Review",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentStep]),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Step ${_currentStep + 1} of 4",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StudentStep(
                  draft: draft,
                  formKey: _studentFormKey,
                ),
                GuardianStep(
                  draft: draft,
                  formKey: _guardianFormKey,
                ),
                AdditionalStep(draft: draft),
                ReviewStep(draft: draft),
              ],
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _back,
                        child: Text(
                          _currentStep == 0
                              ? "Cancel"
                              : "Back",
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _currentStep < 3
                          ? FilledButton(
                        onPressed: _next,
                        child: Text(
                          _currentStep == 2
                              ? "Review"
                              : "Next",
                        ),
                      )
                          : FilledButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.save),
                        label: const Text("SAVE"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
