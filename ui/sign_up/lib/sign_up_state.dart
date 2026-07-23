sealed class SignUpState {
  const SignUpState();
}

final class SignUpFormState extends SignUpState {
  final String? emailError;
  final String? passwordError;
  final String? nicknameError;

  const SignUpFormState({
    this.emailError,
    this.passwordError,
    this.nicknameError,
  });

  bool get isValid =>
      emailError == null && passwordError == null && nicknameError == null;
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}
