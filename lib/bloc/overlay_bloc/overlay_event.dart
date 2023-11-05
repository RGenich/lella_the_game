part of 'overlay_bloc.dart';

@immutable
abstract class OverlayEvent {}

class AddInfoEvent extends OverlayEvent{
  final String info;
  AddInfoEvent(this.info);
}