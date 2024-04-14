import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/error_model.dart';
import '../../repo/repo.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final Repo repo;
  SignUpBloc(this.repo) : super(SignUpInitial()) {
    on<SignUp>((event, emit) async {
      try {
        bool isSaved = await repo.saveNewUser(event.userModel);
        if (isSaved) {
          emit(SignUpSuccess());
        } else {
          emit(
            SignUpFailed(
              const ErrorModel(
                  title: 'Sign Up Failed', description: 'Something went Wrong'),
            ),
          );
        }
      } catch (ex) {
        emit(
          SignUpFailed(
            const ErrorModel(
                title: 'Sign Up Failed',
                description: 'User already regestired with this Username'),
          ),
        );
      }
    });
  }
}
