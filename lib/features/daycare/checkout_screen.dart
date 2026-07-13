import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'models/daycare_session.dart';
import 'services/billing_service.dart';
import 'widgets/billing_summary_card.dart';

class CheckoutScreen extends StatelessWidget {
  final DaycareSession session;

  const CheckoutScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final summary =
    const BillingService().generateSummary(session);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.swayyamGreen,
                    child: Icon(
                      Icons.child_care,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    session.childName,
                    style: AppTextStyles.textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    '${summary.totalMinutes} minutes today',
                  ),
                ),
              ),

              const SizedBox(height: 16),

              BillingSummaryCard(
                summary: summary,
              ),

              const Spacer(),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Complete Check Out'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}