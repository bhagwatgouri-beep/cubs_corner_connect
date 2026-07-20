import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../repositories/billing_repository.dart';

class PaymentScreen extends StatefulWidget {
  final Invoice invoice;

  const PaymentScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _amountController.text =
        widget.invoice.balance.toStringAsFixed(2);
  }

  void _receivePayment() {
    final amount =
        double.tryParse(_amountController.text.trim()) ?? 0;

    if (amount <= 0) return;

    final paid = widget.invoice.amountPaid + amount;
    final balance = widget.invoice.total - paid;

    final updated = widget.invoice.copyWith(
      amountPaid: paid,
      balance: balance < 0 ? 0 : balance,
      status: balance <= 0 ? 'Paid' : 'Partial',
      updatedAt: DateTime.now(),
    );

    BillingRepository.instance.saveInvoice(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Invoice'),
              subtitle: Text(widget.invoice.invoiceNumber),
            ),
            ListTile(
              title: const Text('Outstanding'),
              subtitle: Text(
                '₹${widget.invoice.balance.toStringAsFixed(2)}',
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Amount Received',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _receivePayment,
              icon: const Icon(Icons.payments),
              label: const Text('Receive Payment'),
            ),
          ],
        ),
      ),
    );
  }
}