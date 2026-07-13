import 'package:flutter/material.dart';

import '../models/daycare_child.dart';

class DaycareCheckInDialog extends StatelessWidget {
  final List<DaycareChild> children;

  const DaycareCheckInDialog({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Child'),
      content: SizedBox(
        width: 350,
        height: 400,
        child: ListView.builder(
          itemCount: children.length,
          itemBuilder: (context, index) {
            final child = children[index];

            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.child_care),
              ),
              title: Text(child.name),
              subtitle: Text(child.classroom),
              onTap: () {
                Navigator.pop(context, child);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}