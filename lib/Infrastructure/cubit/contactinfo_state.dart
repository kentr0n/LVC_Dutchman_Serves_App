part of 'contactinfo_cubit.dart';

abstract class ContactinfoState extends Equatable {
  const ContactinfoState();

  @override
  List<Object> get props => [];
}

class ContactinfoInitial extends ContactinfoState {}
class ContactinfoLoading extends ContactinfoState {}
class ContactinfoLoaded extends ContactinfoState {
  
}