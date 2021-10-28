part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  // const UsersState();

  // @override
  // List<Object> get props => [];
}

class UsersInitial extends UsersState {
  List<Object> get props => [];
}

class LoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadedState extends UsersState {
  LoadedState(this.users, this.curUser);
  final User curUser;
  final List<User> users;

  @override
  List<Object> get props => [users];
}

class ErrorState extends UsersState {
  @override
  List<Object> get props => [];
}
