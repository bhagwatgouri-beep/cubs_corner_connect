import 'package:flutter/material.dart';

import '../../../../models/admission_draft.dart';
import '../../../../shared/widgets/photo_picker_card.dart';

class StudentStep extends StatefulWidget {
  final AdmissionDraft draft;
  final GlobalKey<FormState> formKey;

  const StudentStep({
    super.key,
    required this.draft,
    required this.formKey,
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

Future<void> _pickDate(FormFieldState<DateTime> field) async {
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

field.didChange(picked);
}
}

@override
Widget build(BuildContext context) {
final dob = widget.draft.dateOfBirth;

return Form(
key: widget.formKey,
child: ListView(
padding: const EdgeInsets.all(16),
children: [

PhotoPickerCard(
imagePath: widget.draft.profileImageUrl,
onImageSelected: (path) {
setState(() {
widget.draft.profileImageUrl = path;
});
},
title: "Student Photo",
),

const SizedBox(height: 20),

TextField(
controller: _admissionController,
readOnly: true,
decoration: const InputDecoration(
labelText: "Admission Number",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 16),

TextFormField(
controller: _firstNameController,
decoration: const InputDecoration(
labelText: "First Name",
border: OutlineInputBorder(),
),
autovalidateMode: AutovalidateMode.onUserInteraction,
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "First Name is required";
}
return null;
},
onChanged: (value) {
widget.draft.firstName = value;
},
),

const SizedBox(height: 16),

TextFormField(
controller: _lastNameController,
decoration: const InputDecoration(
labelText: "Last Name",
border: OutlineInputBorder(),
),
autovalidateMode: AutovalidateMode.onUserInteraction,
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Last Name is required";
}
return null;
},
onChanged: (value) {
widget.draft.lastName = value;
},
),

const SizedBox(height: 16),

FormField<DateTime>(
initialValue: dob,
autovalidateMode: AutovalidateMode.onUserInteraction,
validator: (value) {
if (value == null) {
return "Date of Birth is required";
}
return null;
},
builder: (field) {
final selectedDate = field.value;

return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
ListTile(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
side: BorderSide(
color: field.hasError
? Theme.of(context).colorScheme.error
: Theme.of(context).colorScheme.outline,
),
),
title: const Text("Date of Birth"),
subtitle: Text(
selectedDate == null
? "Select Date"
: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
),
trailing: const Icon(Icons.calendar_month),
onTap: () => _pickDate(field),
),

if (field.hasError)
Padding(
padding: const EdgeInsets.only(
left: 12,
top: 4,
),
child: Text(
field.errorText!,
style: TextStyle(
color: Theme.of(context).colorScheme.error,
),
),
),
],
);
},
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
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Gender is required";
      }
      return null;
    },
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
      setState(() {
        widget.draft.gender = value ?? "";
      });
    },
  ),

  const SizedBox(height: 24),
],
),
);
}
}