import 'classroom_status.dart';
import 'flow_step.dart';

class FlowEngine {
  ClassroomStatus getCurrentStatus() {
    return const ClassroomStatus(
      currentStep: FlowStep.breakfast,
      totalChildren: 28,
      presentChildren: 26,
    );
  }

  List<FlowStep> getTodaysFlow() {
    return [
      FlowStep.arrival,
      FlowStep.breakfast,
      FlowStep.learning,
      FlowStep.lunch,
      FlowStep.nap,
      FlowStep.snack,
      FlowStep.departure,
    ];
  }

  bool isCompleted(
      FlowStep current,
      FlowStep selected,
      ) {
    return selected.index < current.index;
  }

  bool isCurrent(
      FlowStep current,
      FlowStep selected,
      ) {
    return current == selected;
  }
}