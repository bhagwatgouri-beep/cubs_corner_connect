enum FlowStep {
  arrival,
  breakfast,
  learning,
  lunch,
  nap,
  snack,
  departure,
}

extension FlowStepExtension on FlowStep {
  String get title {
    switch (this) {
      case FlowStep.arrival:
        return "Arrival";

      case FlowStep.breakfast:
        return "Breakfast";

      case FlowStep.learning:
        return "Learning Activity";

      case FlowStep.lunch:
        return "Lunch";

      case FlowStep.nap:
        return "Nap Time";

      case FlowStep.snack:
        return "Evening Snack";

      case FlowStep.departure:
        return "Departure";
    }
  }

  String get emoji {
    switch (this) {
      case FlowStep.arrival:
        return "🏫";

      case FlowStep.breakfast:
        return "🍎";

      case FlowStep.learning:
        return "🎨";

      case FlowStep.lunch:
        return "🍛";

      case FlowStep.nap:
        return "😴";

      case FlowStep.snack:
        return "🍌";

      case FlowStep.departure:
        return "👋";
    }
  }
}