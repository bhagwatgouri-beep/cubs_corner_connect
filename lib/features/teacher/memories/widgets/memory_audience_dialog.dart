import 'package:flutter/material.dart';

import '../models/memory.dart';

class MemoryAudienceSelection {
  final MemoryAudience audience;
  final List<String> selectedChildren;

  const MemoryAudienceSelection({
    required this.audience,
    required this.selectedChildren,
  });
}

class MemoryAudienceDialog extends StatefulWidget {
  final List<String> children;

  const MemoryAudienceDialog({
    super.key,
    required this.children,
  });

  @override
  State<MemoryAudienceDialog> createState() => _MemoryAudienceDialogState();
}

class _MemoryAudienceDialogState extends State<MemoryAudienceDialog> {
  MemoryAudience _audience = MemoryAudience.entireClass;
  final Set<String> _selectedChildren = {};

  bool get _canSave =>
      _audience == MemoryAudience.entireClass || _selectedChildren.isNotEmpty;

  void _save() {
    if (!_canSave) {
      return;
    }

    Navigator.of(context).pop(
      MemoryAudienceSelection(
        audience: _audience,
        selectedChildren: _audience == MemoryAudience.entireClass
            ? const []
            : _selectedChildren.toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Memory For'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<MemoryAudience>(
              value: MemoryAudience.entireClass,
              groupValue: _audience,
              onChanged: _setAudience,
              title: const Text('Entire Class'),
            ),
            RadioListTile<MemoryAudience>(
              value: MemoryAudience.selectedChildren,
              groupValue: _audience,
              onChanged: _setAudience,
              title: const Text('Select Children'),
            ),
            if (_audience == MemoryAudience.selectedChildren) ...[
              const Divider(),
              ...widget.children.map(
                (child) => CheckboxListTile(
                  value: _selectedChildren.contains(child),
                  onChanged: (selected) {
                    setState(() {
                      if (selected == true) {
                        _selectedChildren.add(child);
                      } else {
                        _selectedChildren.remove(child);
                      }
                    });
                  },
                  title: Text(child),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _canSave ? _save : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _setAudience(MemoryAudience? audience) {
    if (audience == null) {
      return;
    }

    setState(() {
      _audience = audience;
    });
  }
}
