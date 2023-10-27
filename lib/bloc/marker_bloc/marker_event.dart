part of 'marker_bloc.dart';

@immutable
abstract class MarkerEvent {}

class TimeToMoveMarkerEvent extends MarkerEvent {}
class MarkerInitialEvent extends MarkerEvent {}
