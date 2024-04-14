
import '../../../model/sign_in_model.dart';

abstract class SignInEvent {}

class SignIn extends SignInEvent {
  SignIn(this.signInModel);
  final SignInModel signInModel;
}

class GetSignInCredential extends SignInEvent {}
