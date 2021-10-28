import 'package:dutchmenserve/models/event.dart';
import 'package:dutchmenserve/models/interest.dart';
import 'package:equatable/equatable.dart';

abstract class EventState extends Equatable {}

class InitialState extends EventState {
  @override
  List<Object> get props => [];
}

class LoadingState extends EventState {
  @override
  List<Object> get props => [];
}

class LoadedState extends EventState {
  LoadedState(this.events, this.interests);

  final List<Event> events;
  final List<Interest> interests;

  @override
  List<Object> get props => [events, interests];
}

class ErrorState extends EventState {
  @override
  List<Object> get props => [];
}

class RegistrationSuccessState extends EventState {
  RegistrationSuccessState(this.eventName);

  final String eventName;
  @override
  List<Object> get props => [eventName];
}

class RegistrationFailedState extends EventState {
  RegistrationFailedState(this.eventName);
  final String eventName;

  @override
  List<Object> get props => [eventName];
}

class UnregisterSuccessState extends EventState {
  UnregisterSuccessState(this.eventName);
  final String eventName;
  @override
  List<Object> get props => [eventName];
}

class UnregisterFailedState extends EventState {
  UnregisterFailedState(this.eventName);
  final String eventName;
  @override
  List<Object> get props => [eventName];
}

class LookingUpEvent extends EventState {
  @override
  List<Object> get props => [];
}

class LookedUpEvent extends EventState {
  final Event event;
  LookedUpEvent(this.event);
  @override
  List<Object> get props => [event];
}

class LookupError extends EventState {
  @override
  List<Object> get props => [];
}

class PostedEvent extends EventState {
  final Event event;
  PostedEvent(this.event);
  @override
  List<Object> get props => [event];
}

class PostingEvent extends EventState {
  @override
  List<Object> get props => [];
}
