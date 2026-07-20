import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../repositories/billing_repository.dart';
import 'delete_invoice_dialog.dart';
import 'edit_invoice_screen.dart';
import 'payment_screen.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceDetailsScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<InvoiceDetailsScreen> createState() =>
      _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState
    extends State<InvoiceDetailsScreen> {
  late Invoice _invoice;

  @override
  void initState() {
    super.initState();
    _invoice = widget.invoice;
  }

  Widget _row(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _editInvoice() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditInvoiceScreen(
          invoice: _invoice,
        ),
      ),
    );

    final updated = BillingRepository.instance.getInvoice(_invoice.id);

    if (updated != null && mounted) {
      setState(() {
        _invoice = updated;
      });
    }
  }

  Future<void> _receivePayment() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          invoice: _invoice,
        ),
      ),
    );

    final updated = BillingRepository.instance.getInvoice(_invoice.id);

    if (updated != null && mounted) {
      setState(() {
        _invoice = updated;
      });
    }
  }

  void _deleteInvoice() {
    BillingRepository.instance.deleteInvoice(_invoice.id);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_invoice.invoiceNumber),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editInvoice,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => DeleteInvoiceDialog(
                  onDelete: _deleteInvoice,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                _row('Invoice No.', _invoice.invoiceNumber),
                _row('Status', _invoice.status),
                _row(
                  'Subtotal',
                  '₹${_invoice.subtotal.toStringAsFixed(2)}',
                ),
                _row(
                  'Discount',
                  '₹${_invoice.discount.toStringAsFixed(2)}',
                ),
                _row(
                  'Tax',
                  '₹${_invoice.tax.toStringAsFixed(2)}',
                ),
                _row(
                  'Total',
                  '₹${_invoice.total.toStringAsFixed(2)}',
                ),
                _row(
                  'Paid',
                  '₹${_invoice.amountPaid.toStringAsFixed(2)}',
                ),
                _row(
                  'Balance',
                  '₹${_invoice.balance.toStringAsFixed(2)}',
                ),
                _row(
                  'Remarks',
                  _invoice.remarks.isEmpty
                      ? '-'
                      : _invoice.remarks,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: _receivePayment,
              icon: const Icon(Icons.payments),
              label: const Text('Receive Payment'),
            ),
          ),
        ],
      ),
    );
  }
}