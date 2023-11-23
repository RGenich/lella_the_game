part of 'overlay_bloc.dart';

@immutable
abstract class TopOverlayState {}

class OverlayInitial extends TopOverlayState {}


class InfoAddedState extends TopOverlayState{
  final List<OverlayStep> steps;
  InfoAddedState(this.steps);
}
