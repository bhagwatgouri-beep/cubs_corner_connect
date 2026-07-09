import 'flow_step.dart';

class ClassroomStatus {
  final FlowStep currentStep;
  final int totalChildren;
  final int presentChildren;

  const ClassroomStatus({
    required this.currentStep,
    required this.totalChildren,
    required this.presentChildren,
  });

  double get attendancePercentage =>
      (presentChildren / totalChildren) * 100;
}