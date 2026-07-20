import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../repositories/billing_repository.dart';

class EditInvoiceScreen extends StatefulWidget {
  final Invoice invoice;

  const EditInvoiceScreen({
    super.key,
    required this.invoice,
  });

  @override
  State<EditInvoiceScreen> createState() =>
      _EditInvoiceScreenState();
}

class _EditInvoiceScreenState
    extends State<EditInvoiceScreen> {
  late final TextEditingController _subtotalController;
  late final TextEditingController _discountController;
  late final TextEditingController _taxController;
  late final TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();

    _subtotalController = TextEditingController(
      text: widget.invoice.subtotal.toStringAsFixed(2),
    );

    _discountController = TextEditingController(
      text: widget.invoice.discount.toStringAsFixed(2),
    );

    _taxController = TextEditingController(
      text: widget.invoice.tax.toStringAsFixed(2),
    );

    _remarksController = TextEditingController(
      text: widget.invoice.remarks,
    );
  }

  @override
  void dispose() {
    _subtotalController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _save() {
    final subtotal =
        double.tryParse(_subtotalController.text) ?? 0;

    final discount =
        double.tryParse(_discountController.text) ?? 0;

    final tax =
        double.tryParse(_taxController.text) ?? 0;

    final total = subtotal - discount + tax;

    final paid = widget.invoice.amountPaid;
    final balance = total - paid;

    final updated = widget.invoice.copyWith(
      subtotal: subtotal,
      discount: discount,
      tax: tax,
      total: total,
      balance: balance < 0 ? 0 : balance,
      remarks: _remarksController.text.trim(),
      status: balance <= 0 ? 'Paid' : 'Pending',
      updatedAt: DateTime.now(),
    );

    BillingRepository.instance.saveInvoice(updated);

    Navigator.pop(context, true);
  }

  Widget _field(
      String label,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType:
        const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.invoice.invoiceNumber),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _field(
              'Subtotal',
              _subtotalController,
            ),
            _field(
              'Discount',
              _discountController,
            ),
            _field(
              'Tax',
              _taxController,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextField(
                controller: _remarksController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Remarks',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('Save Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}