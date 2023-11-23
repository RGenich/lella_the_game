part of 'overlay_bloc.dart';

@immutable
abstract class OverlayEvent {}

class UpdateOverlayEvent extends OverlayEvent {
  UpdateOverlayEvent();
}
