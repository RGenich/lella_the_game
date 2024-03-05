part of 'marker_bloc.dart';

@immutable
abstract class MarkerState {
  // late final Offset position;
  // late final Size size;
  // final bool isDestinationReach;
  //
  // MarkerState({this.isDestinationReach = false});
}

class MarkerInitialState extends MarkerState {
  MarkerInitialState();
}

class MarkerReadyState extends MarkerState {
  final Offset position;
  final Size size;
  final bool isDestinationReach;
  MarkerReadyState({required this.isDestinationReach, required this.size,required this.position});
}

class MarkerMovingState extends MarkerReadyState {

  MarkerMovingState({ required Size size, required Offset position, required isDestinationReach})
      : super(isDestinationReach: isDestinationReach, size: size, position: position);
}

