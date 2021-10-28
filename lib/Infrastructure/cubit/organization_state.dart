part of 'organization_cubit.dart';

abstract class OrganizationState extends Equatable {
  // const OrganizationState();

  // @override
  // List<Object> get props => [];
}

class OrganizationInitial extends OrganizationState {
  @override
  List<Object> get props => [];
}

class LoadingState extends OrganizationState {
  @override
  List<Object> get props => [];
}

class LoadedState extends OrganizationState {
  LoadedState(this.orgs);

  final List<Organization> orgs;

  @override
  List<Object> get props => [orgs];
}

class ErrorState extends OrganizationState {
  @override
  List<Object> get props => [];
}


