part of 'marker_bloc.dart';

@immutable
abstract class MarkerState {
  late final Offset position;
  final bool isDestinationReach;

  MarkerState({this.isDestinationReach = false});
}

class MarkerInitialState extends MarkerState {
  // final Offset position;

  MarkerInitialState();
}
class MarkerFirstShowState extends MarkerState {
  final Offset position;
  MarkerFirstShowState({required this.position});
}

class MarkerMovingState extends MarkerState {
  final Offset position;
  MarkerMovingState({required this.position, required isDestinationReach})
      : super(isDestinationReach: isDestinationReach);
}
