import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../../models/student.dart';
import '../../../repositories/billing_repository.dart';
import '../../../repositories/student_repository.dart';

class GenerateInvoiceScreen extends StatefulWidget {
  final Student? student;

  const GenerateInvoiceScreen({
    super.key,
    this.student,
  });

  @override
  State<GenerateInvoiceScreen> createState() =>
      _GenerateInvoiceScreenState();
}

class _GenerateInvoiceScreenState
    extends State<GenerateInvoiceScreen> {
  final StudentRepository _studentRepository =
      StudentRepository.instance;

  Student? _selectedStudent;

  final TextEditingController _amountController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedStudent = widget.student;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _generateInvoice() {
    if (_selectedStudent == null) return;

    final subtotal =
        double.tryParse(_amountController.text.trim()) ?? 0;

    if (subtotal <= 0) return;

    final now = DateTime.now();

    final invoice = Invoice(
      id: now.microsecondsSinceEpoch.toString(),
      invoiceNumber:
      'INV${now.year}${now.microsecondsSinceEpoch}',
      studentId: _selectedStudent!.id,
      invoiceDate: now,
      dueDate: now.add(const Duration(days: 15)),
      subtotal: subtotal,
      total: subtotal,
      balance: subtotal,
      createdAt: now,
      updatedAt: now,
    );

    BillingRepository.instance.saveInvoice(invoice);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invoice generated successfully'),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final students = _studentRepository.activeStudents;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Invoice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Student>(
              value: _selectedStudent,
              decoration: const InputDecoration(
                labelText: 'Student',
                border: OutlineInputBorder(),
              ),
              items: students
                  .map(
                    (student) => DropdownMenuItem(
                  value: student,
                  child: Text(student.fullName),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStudent = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Invoice Amount',
                border: OutlineInputBorder(),
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _generateInvoice,
              icon: const Icon(Icons.receipt_long),
              label: const Text('Generate Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}