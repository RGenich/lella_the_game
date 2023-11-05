part of 'marker_bloc.dart';

@immutable
abstract class MarkerEvent {}

class IsShouldMarkerMoveEvent extends MarkerEvent {}
class MarkerInitialEvent extends MarkerEvent {}
class MarkerSizeDefiningEvent extends MarkerEvent {}
class MarkerFirstShowEvent extends MarkerEvent {}
class PlayZoneKeyDefinedEvent extends MarkerEvent{
  late final GlobalKey playZoneKey;

  PlayZoneKeyDefinedEvent(this.playZoneKey);
}
