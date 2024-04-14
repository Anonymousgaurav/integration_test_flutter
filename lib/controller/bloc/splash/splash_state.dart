
import '../../../model/error_model.dart';
import '../../../model/sign_in_model.dart';
import '../../../model/user_model.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class GetSignInCredentialSuccess extends SplashState {
  GetSignInCredentialSuccess(this.signInModel);
  final SignInModel signInModel;
}

class GetSignInCredentialFailed extends SplashState {
  GetSignInCredentialFailed(this.error);
  final ErrorModel error;
}

class AlreadySignedIn extends SplashState {
  AlreadySignedIn(this.user);
  final UserModel user;
}
