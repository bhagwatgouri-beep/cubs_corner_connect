import 'package:flutter/material.dart';

import '../../../repositories/billing_repository.dart';
import 'billing_reports_screen.dart';
import 'generate_invoice_screen.dart';
import 'invoice_list_screen.dart';

class BillingDashboardScreen extends StatelessWidget {
  const BillingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BillingRepository.instance;

    final pending = repository.pendingInvoices();
    final outstanding = repository.totalOutstanding();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Pending Invoices'),
              trailing: Text(
                pending.length.toString(),
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
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GenerateInvoiceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Generate Invoice'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InvoiceListScreen(),
                ),
              );
            },
            icon: const Icon(Icons.receipt_long),
            label: const Text('View Invoices'),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BillingReportsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.assessment),
            label: const Text('Billing Reports'),
          ),
        ],
      ),
    );
  }
}