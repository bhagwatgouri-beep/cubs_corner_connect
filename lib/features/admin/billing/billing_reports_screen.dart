import 'package:flutter/material.dart';

import '../../../repositories/billing_repository.dart';

class BillingReportsScreen extends StatelessWidget {
  const BillingReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BillingRepository.instance;

    final invoices = repository.invoices;
    final outstanding = repository.totalOutstanding();

    final paid = invoices
        .where((invoice) => invoice.balance == 0)
        .length;

    final pending = invoices
        .where((invoice) => invoice.balance > 0)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Total Invoices'),
              trailing: Text(
                invoices.length.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Paid Invoices'),
              trailing: Text(
                paid.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.pending_actions),
              title: const Text('Pending Invoices'),
              trailing: Text(
                pending.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text('Outstanding Amount'),
              trailing: Text(
                '₹${outstanding.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}