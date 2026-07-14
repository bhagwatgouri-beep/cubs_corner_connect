import 'package:flutter/material.dart';

import '../../models/parent.dart';
import '../../repositories/parent_repository.dart';

class ParentSelector extends StatefulWidget {
  final ValueChanged<Parent> onParentSelected;

  const ParentSelector({
    super.key,
    required this.onParentSelected,
  });

  @override
  State<ParentSelector> createState() => _ParentSelectorState();
}

class _ParentSelectorState extends State<ParentSelector> {
  final TextEditingController _mobileController =
  TextEditingController();

  Parent? _selectedParent;

  void _search() {
    final parent = ParentRepository.instance.getByMobile(
      _mobileController.text.trim(),
    );

    setState(() {
      _selectedParent = parent;
    });

    if (parent != null) {
      widget.onParentSelected(parent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Existing parent found: ${parent.fullName}",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "No parent found. A new parent will be created.",
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Parent Mobile Number",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),

            if (_selectedParent != null) ...[
              const SizedBox(height: 16),

              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(_selectedParent!.fullName),
                subtitle: Text(
                  _selectedParent!.mobileNumber,
                ),
                trailing: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}