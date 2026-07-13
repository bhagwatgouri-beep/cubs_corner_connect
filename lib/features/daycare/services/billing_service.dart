import '../models/daycare_session.dart';

class BillingService {
  const BillingService({
    this.hourlyRate = 75.0,
    this.breakfastRate = 30.0,
    this.lunchRate = 60.0,
    this.snackRate = 25.0,
  });

  final double hourlyRate;
  final double breakfastRate;
  final double lunchRate;
  final double snackRate;

  double calculateDaycareCharge(DaycareSession session) {
    return session.totalHours * hourlyRate;
  }

  double calculateMealCharge(DaycareSession session) {
    double total = 0;

    if (session.breakfastTaken) {
      total += breakfastRate;
    }

    if (session.lunchTaken) {
      total += lunchRate;
    }

    if (session.snackTaken) {
      total += snackRate;
    }

    return total;
  }

  double calculateTotal(DaycareSession session) {
    return calculateDaycareCharge(session) +
        calculateMealCharge(session);
  }

  BillingSummary generateSummary(DaycareSession session) {
    final daycare = calculateDaycareCharge(session);
    final meals = calculateMealCharge(session);

    return BillingSummary(
      daycareCharge: daycare,
      mealCharge: meals,
      totalAmount: daycare + meals,
      totalMinutes: session.totalMinutes,
      totalHours: session.totalHours,
    );
  }
}

class BillingSummary {
  final double daycareCharge;
  final double mealCharge;
  final double totalAmount;
  final int totalMinutes;
  final double totalHours;

  const BillingSummary({
    required this.daycareCharge,
    required this.mealCharge,
    required this.totalAmount,
    required this.totalMinutes,
    required this.totalHours,
  });
}