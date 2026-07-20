import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../repositories/billing_repository.dart';
import 'invoice_details_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  Future<void> _openInvoice(Invoice invoice) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InvoiceDetailsScreen(
          invoice: invoice,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoices = BillingRepository.instance.invoices;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: invoices.isEmpty
          ? const Center(
        child: Text('No invoices available.'),
      )
          : ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: ListTile(
              onTap: () => _openInvoice(invoice),
              leading: const CircleAvatar(
                child: Icon(Icons.receipt_long),
              ),
              title: Text(invoice.invoiceNumber),
              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text('Status: ${invoice.status}'),
                  Text(
                    'Balance: ₹${invoice.balance.toStringAsFixed(2)}',
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${invoice.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}