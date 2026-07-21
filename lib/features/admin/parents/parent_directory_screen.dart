import 'package:flutter/material.dart';
import 'parent_profile_screen.dart';
import '../../../repositories/parent_repository.dart';

class ParentDirectoryScreen extends StatefulWidget {
  const ParentDirectoryScreen({super.key});

  @override
  State<ParentDirectoryScreen> createState() =>
      _ParentDirectoryScreenState();
}

class _ParentDirectoryScreenState
    extends State<ParentDirectoryScreen> {
  final repository = ParentRepository.instance;

  String _search = '';

  @override
  Widget build(BuildContext context) {
    final parents = repository.parents.where((parent) {
      if (_search.isEmpty) return true;

      final q = _search.toLowerCase();

      return parent.fullName.toLowerCase().contains(q) ||
          parent.mobileNumber.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Directory"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search parent",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
            ),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.people),
              ),
              title: const Text("Total Parents"),
              trailing: Text(
                parents.length.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: parents.isEmpty
                ? const Center(
              child: Text("No parents found"),
            )
                : ListView.builder(
              itemCount: parents.length,
              itemBuilder: (context, index) {
                final parent = parents[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        parent.firstName.isEmpty
                            ? "?"
                            : parent.firstName[0]
                            .toUpperCase(),
                      ),
                    ),
                    title: Text(parent.fullName),
                    subtitle: Text(
                      parent.mobileNumber,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ParentProfileScreen(
                            parent: parent,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}