import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contactinfo_state.dart';

class ContactinfoCubit extends Cubit<ContactinfoState> {
  ContactinfoCubit() : super(ContactinfoInitial());
}
