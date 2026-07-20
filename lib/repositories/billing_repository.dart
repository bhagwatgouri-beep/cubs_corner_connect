import '../models/invoice.dart';

class BillingRepository {
  BillingRepository._();

  static final BillingRepository instance = BillingRepository._();

  final List<Invoice> _invoices = [];

  List<Invoice> get invoices => List.unmodifiable(_invoices);

  void saveInvoice(Invoice invoice) {
    _invoices.removeWhere((i) => i.id == invoice.id);
    _invoices.add(invoice);
  }

  void saveInvoices(List<Invoice> invoices) {
    for (final invoice in invoices) {
      saveInvoice(invoice);
    }
  }

  Invoice? getInvoice(String id) {
    try {
      return _invoices.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  void deleteInvoice(String id) {
    _invoices.removeWhere((invoice) => invoice.id == id);
  }

  bool invoiceExists(String id) {
    return _invoices.any((invoice) => invoice.id == id);
  }

  List<Invoice> invoicesForStudent(String studentId) {
    return _invoices
        .where((invoice) => invoice.studentId == studentId)
        .toList();
  }

  List<Invoice> pendingInvoices() {
    return _invoices
        .where((invoice) => invoice.balance > 0)
        .toList();
  }

  List<Invoice> paidInvoices() {
    return _invoices
        .where((invoice) => invoice.balance <= 0)
        .toList();
  }

  double totalOutstanding() {
    return _invoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.balance,
    );
  }

  double totalCollected() {
    return _invoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.amountPaid,
    );
  }

  int totalInvoices() {
    return _invoices.length;
  }

  void clear() {
    _invoices.clear();
  }
}