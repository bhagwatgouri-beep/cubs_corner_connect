import 'package:flutter/material.dart';

import '../../../../models/student.dart';

class BillingTab extends StatelessWidget {
  final Student student;

  const BillingTab({
    super.key,
    required this.student,
  });

  Widget _summaryCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
      String title,
      String value,
      ) {
    return ListTile(
      leading: const Icon(Icons.receipt_long),
      title: Text(title),
      trailing: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: _summaryCard(
                context,
                'Outstanding',
                '₹0',
                Icons.currency_rupee,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _summaryCard(
                context,
                'Paid',
                '₹0',
                Icons.payments,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: Column(
            children: [
              _infoTile(
                'Total Invoices',
                '0',
              ),
              _infoTile(
                'Pending',
                '0',
              ),
              _infoTile(
                'Last Payment',
                '-',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Billing history will appear here.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}