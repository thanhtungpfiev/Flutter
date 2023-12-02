part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class TriggerAppEvent extends AppEvent {
  final int index;

  const TriggerAppEvent(this.index);
}
