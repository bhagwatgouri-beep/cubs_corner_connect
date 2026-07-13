import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../services/billing_service.dart';

class BillingSummaryCard extends StatelessWidget {
  final BillingSummary summary;

  const BillingSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Billing Summary',
              style: AppTextStyles.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            _row(
              'Duration',
              '${summary.totalHours.toStringAsFixed(2)} hrs',
            ),

            _row(
              'Daycare',
              '₹${summary.daycareCharge.toStringAsFixed(2)}',
            ),

            _row(
              'Meals',
              '₹${summary.mealCharge.toStringAsFixed(2)}',
            ),

            const Divider(height: 24),

            _row(
              'Total',
              '₹${summary.totalAmount.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    final style = isTotal
        ? AppTextStyles.textTheme.titleLarge
        : AppTextStyles.textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: style),
          ),
          Text(
            value,
            style: style?.copyWith(
              color: isTotal ? AppColors.swayyamGreen : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}