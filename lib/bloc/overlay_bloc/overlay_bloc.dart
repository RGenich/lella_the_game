import 'dart:async';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'overlay_event.dart';
part 'overlay_state.dart';

class OverlayBloc extends Bloc<OverlayEvent, TopOverlayState> {
  final Repository repository;

  OverlayBloc(this.repository) : super(OverlayInitial()) {

    on<AddInfoEvent>((event, emit) {
        repository.addTrace(event.info);
        emit(InfoAddedState(repository.traces));
    });
  }
}
