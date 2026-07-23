import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_ui/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  SignUpCubit() : super(const SignUpFormState());

  String? validateEmail(String email) {
    if (email.isEmpty) return 'required';
    if (!_emailRegex.hasMatch(email)) return 'invalid';
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'required';
    if (password.length < 6) return 'too_short';
    return null;
  }

  String? validateNickname(String nickname) {
    if (nickname.isEmpty) return 'required';
    return null;
  }

  void createAccount(String email, String password, String nickname) {
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);
    final nicknameError = validateNickname(nickname);

    if (emailError != null || passwordError != null || nicknameError != null) {
      emit(SignUpFormState(
        emailError: emailError,
        passwordError: passwordError,
        nicknameError: nicknameError,
      ));
      return;
    }

    // No backend integration - just emit success
    emit(const SignUpSuccess());
  }
}
