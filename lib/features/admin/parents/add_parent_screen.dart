import 'package:flutter/material.dart';

import '../../../models/parent.dart';
import '../../../repositories/parent_repository.dart';

class AddParentScreen extends StatefulWidget {
  const AddParentScreen({super.key});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _occupation = TextEditingController();
  final _address = TextEditingController();

  String relationship = "Mother";
  bool primaryContact = true;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _mobile.dispose();
    _email.dispose();
    _occupation.dispose();
    _address.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final parent = Parent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      mobileNumber: _mobile.text.trim(),
      email: _email.text.trim(),
      relationship: relationship,
      occupation: _occupation.text.trim(),
      address: _address.text.trim(),
      isPrimaryContact: primaryContact,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    ParentRepository.instance.addParent(parent);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Parent"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _firstName,
              decoration: const InputDecoration(
                labelText: "First Name",
              ),
              validator: (v) =>
              v == null || v.isEmpty ? "Required" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _lastName,
              decoration: const InputDecoration(
                labelText: "Last Name",
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: relationship,
              decoration: const InputDecoration(
                labelText: "Relationship",
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
                  value: "Guardian",
                  child: Text("Guardian"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  relationship = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _mobile,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _occupation,
              decoration: const InputDecoration(
                labelText: "Occupation",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _address,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              value: primaryContact,
              title: const Text("Primary Contact"),
              onChanged: (value) {
                setState(() {
                  primaryContact = value;
                });
              },
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: _save,
              child: const Text("SAVE"),
            ),
          ],
        ),
      ),
    );
  }
}