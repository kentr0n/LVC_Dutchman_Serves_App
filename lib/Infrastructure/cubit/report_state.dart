import 'package:dutchmenserve/models/event.dart';
import 'package:dutchmenserve/models/interest.dart';
import 'package:dutchmenserve/models/report.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {}

class ReportInitialState extends ReportState {
  @override
  List<Object> get props => [];
}

class SendReportLoadingState extends ReportState {
  @override
  List<Object> get props => [];
}

class SendReportSuccessState extends ReportState {
  final String eventName;
  SendReportSuccessState(this.eventName);
  @override
  List<Object> get props => [];
}

class SendReportFailedState extends ReportState {
  final String eventName;
  SendReportFailedState(this.eventName);
  @override
  List<Object> get props => [];
}

class ReportLoadingState extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportLoadedState extends ReportState {
  final List<Report> reports;
  final List<Event> events;
  final List<Interest> interests;

  ReportLoadedState(this.reports, this.events, this.interests);

  @override
  List<Object> get props => [reports, events, interests];
}

class ReportErrorState extends ReportState {
  @override
  List<Object> get props => [];
}
