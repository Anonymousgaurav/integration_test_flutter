
import '../../../model/error_model.dart';
import '../../../model/sign_in_model.dart';
import '../../../model/user_model.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess(this.user);
  final UserModel user;
}

class SignInFailed extends SignInState {
  SignInFailed(this.error);
  final ErrorModel error;
}

class GetSignInCredentialSuccess extends SignInState {
  GetSignInCredentialSuccess(this.signInModel);
  final SignInModel signInModel;
}
