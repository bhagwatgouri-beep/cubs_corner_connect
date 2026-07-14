import 'package:flutter/material.dart';

import '../../../models/parent.dart';

class ParentProfileScreen extends StatelessWidget {
  final Parent parent;

  const ParentProfileScreen({
    super.key,
    required this.parent,
  });

  Widget _tile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? "-" : value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parent.fullName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      parent.firstName.isEmpty
                          ? "?"
                          : parent.firstName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    parent.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  Text(parent.relationship),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                _tile("Mobile", parent.mobileNumber),
                const Divider(height: 1),
                _tile("Email", parent.email),
                const Divider(height: 1),
                _tile("Occupation", parent.occupation),
                const Divider(height: 1),
                _tile("Address", parent.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}