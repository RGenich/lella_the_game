

class OverlayStep {
  final String header;
  final StepType stepType;

  OverlayStep({required this.header, required this.stepType});
}

enum StepType {
  USUAL,
  SNAKE,
  ARROW,
  START
}