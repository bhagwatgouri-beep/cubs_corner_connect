class Invoice {
  final String id;
  final String invoiceNumber;

  final String studentId;

  final DateTime invoiceDate;
  final DateTime dueDate;

  final double subtotal;
  final double discount;
  final double tax;
  final double total;

  final double amountPaid;
  final double balance;

  final String status;

  final String remarks;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.studentId,
    required this.invoiceDate,
    required this.dueDate,
    required this.subtotal,
    this.discount = 0,
    this.tax = 0,
    required this.total,
    this.amountPaid = 0,
    required this.balance,
    this.status = 'Pending',
    this.remarks = '',
    required this.createdAt,
    required this.updatedAt,
  });

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? studentId,
    DateTime? invoiceDate,
    DateTime? dueDate,
    double? subtotal,
    double? discount,
    double? tax,
    double? total,
    double? amountPaid,
    double? balance,
    String? status,
    String? remarks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      studentId: studentId ?? this.studentId,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      amountPaid: amountPaid ?? this.amountPaid,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Invoice.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return Invoice(
      id: id,
      invoiceNumber: map['invoiceNumber'] ?? '',
      studentId: map['studentId'] ?? '',
      invoiceDate:
      DateTime.tryParse(map['invoiceDate'] ?? '') ?? DateTime.now(),
      dueDate:
      DateTime.tryParse(map['dueDate'] ?? '') ?? DateTime.now(),
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      tax: (map['tax'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      amountPaid: (map['amountPaid'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      status: map['status'] ?? 'Pending',
      remarks: map['remarks'] ?? '',
      createdAt:
      DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
      DateTime.tryParse(map['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'studentId': studentId,
      'invoiceDate': invoiceDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'subtotal': subtotal,
      'discount': discount,
      'tax': tax,
      'total': total,
      'amountPaid': amountPaid,
      'balance': balance,
      'status': status,
      'remarks': remarks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Invoice && other.id == id;

  @override
  int get hashCode => id.hashCode;
}