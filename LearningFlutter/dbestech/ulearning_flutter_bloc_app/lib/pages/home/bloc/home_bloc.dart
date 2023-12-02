import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeDotsEvent>(_homeDots);
  }

  FutureOr<void> _homeDots(HomeDotsEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
