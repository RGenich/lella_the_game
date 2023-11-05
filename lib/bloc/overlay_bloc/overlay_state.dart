part of 'overlay_bloc.dart';

@immutable
abstract class TopOverlayState {}

class OverlayInitial extends TopOverlayState {}


class InfoAddedState extends TopOverlayState{
  final List<String> info;
  InfoAddedState(this.info);
}
