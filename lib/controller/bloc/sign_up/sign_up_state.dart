
import '../../../model/error_model.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {
  SignUpFailed(this.error);
  final ErrorModel error;
}
