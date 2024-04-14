import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/error_model.dart';
import '../../repo/repo.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repo repo;
  HomeBloc(this.repo) : super(HomeInitial()) {
    on<SignOut>((event, emit) async {
      bool isRemoved = await repo.signOut(event.userName);
      if (isRemoved) {
        emit(SignOutSuccess());
      } else {
        emit(SignOutFailed(const ErrorModel(
            title: 'SignOut Failed', description: 'Something went wrong')));
      }
    });
    on<DeleteUser>(
      (event, emit) async {
        bool isUserDeleted = await repo.removeUserDetail(event.userName);
        if (isUserDeleted) {
          emit(UserDeleteSuccess());
          add(SignOut(event.userName));
        } else {
          emit(UserDeleteFailed(const ErrorModel(
              title: 'Delete User',
              description: 'Unable to delete user record')));
        }
      },
    );
  }
}
