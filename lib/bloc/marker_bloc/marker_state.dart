part of 'marker_bloc.dart';

@immutable
abstract class MarkerState {
  late final Offset position;
}

class MarkerInitialState extends MarkerState {
  final Offset position = Offset.zero;
  MarkerInitialState();
}
class MarkerMovingState extends MarkerState {
  final Offset position;

  MarkerMovingState({required this.position});
}
