import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_test_flutter/controller/bloc/splash/splash_event.dart';
import 'package:integration_test_flutter/controller/bloc/splash/splash_state.dart';

import '../../../model/error_model.dart';
import '../../../model/sign_in_model.dart';
import '../../../model/user_model.dart';
import '../../repo/repo.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final Repo repo;
  SplashBloc(this.repo) : super(SplashInitial()) {
    on<GetSignInCredential>((event, emit) async {
      SignInModel? signCredentials = await repo.getSignInDetails();
      if (signCredentials != null) {
        if (signCredentials.alreadySignedIn) {
          UserModel? user = await repo.getUserDetails(signCredentials.userName);
          if (user != null) {
            if (user.password == signCredentials.password) {
              emit(AlreadySignedIn(user));
            } else {
              emit(GetSignInCredentialSuccess(signCredentials));
            }
          } else {
            emit(GetSignInCredentialSuccess(signCredentials));
          }
        } else {
          emit(GetSignInCredentialSuccess(signCredentials));
        }
      } else {
        emit(GetSignInCredentialFailed(const ErrorModel(
            title: 'Unable to Get SignIn Credentail',
            description: 'No Credentials found')));
      }
    });
  }
}
