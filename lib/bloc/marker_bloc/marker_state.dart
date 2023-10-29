part of 'marker_bloc.dart';

@immutable
abstract class MarkerState {
  late final Offset position;
  late final Size size;
  final bool isDestinationReach;

  MarkerState({this.isDestinationReach = false});
}

class MarkerInitialState extends MarkerState {
  MarkerInitialState();
}

class MarkerFirstShowState extends MarkerState {
  final Offset position;
  final Size size;

  MarkerFirstShowState({required this.size,required this.position});
}

class MarkerSizeDefinedState extends MarkerState {

}

class MarkerMovingState extends MarkerState {
  final Offset position;
  final Size size;
  MarkerMovingState({ required this.size, required this.position, required isDestinationReach})
      : super(isDestinationReach: isDestinationReach);
}
