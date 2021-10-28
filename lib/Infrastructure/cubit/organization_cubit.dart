import 'package:bloc/bloc.dart';
import 'package:dutchmenserve/Infrastructure/repository.dart';
import 'package:dutchmenserve/main.dart';
import 'package:dutchmenserve/models/organization.dart';
import 'package:equatable/equatable.dart';

part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  Repository _repository;

  OrganizationCubit() : super(OrganizationInitial()) {
    _repository = getIt<Repository>();
    getOrgs();
  }

  void getOrgs() async {
    try {
      emit(LoadingState());
      final organizations = await _repository.getOrganizations();
      //TODO research what this line does
      final activeOrgs = organizations.where((f) => f.deleted).toList();
      emit(LoadedState(organizations));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void addOrg(Organization o1) async {
    try {
      //emit(LoadingState());
      await _repository.addOrganization(o1);
      //final organizations = await orgRepo.getOrganization();
      //emit(LoadedState(organizations));
    } catch (e) {
      // emit(ErrorState());
    }
  }

  void removeOrg(Organization o) async {
    try {
      //emit(LoadingState());
      o.deleted = true;
      // await _repository.deleteOrganization(o);
      //final organizations = await orgRepo.getOrganization();
      //emit(LoadedState(organizations));
    } catch (e) {
      // emit(ErrorState());
    }
  }

  // void editOrg(Organization o1,
  //     {String orgName,
  //     List users,
  //     List officers,
  //     String description,
  //     String email,
  //     String imagepath}) async {
  //   try {
  //     //emit(LoadingState());
  //     await _repository.updateOrganization(o1);
  //     //final organizations = await orgRepo.getOrganization();
  //     //emit(LoadedState(organizations));
  //   } catch (e) {
  //     // emit(ErrorState());
  //   }
  // }
}
