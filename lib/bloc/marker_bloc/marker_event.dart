part of 'marker_bloc.dart';

@immutable
abstract class MarkerEvent {}

class TimeToMoveMarkerEvent extends MarkerEvent {}
class MarkerInitialEvent extends MarkerEvent {}
class MarkerSizeDefinedEvent extends MarkerEvent {
  final Size size;

  MarkerSizeDefinedEvent(this.size);

}
class MarkerFirstShowEvent extends MarkerEvent {}
