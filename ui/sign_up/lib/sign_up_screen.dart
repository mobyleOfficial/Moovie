import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/common.dart';
import 'package:sign_up_ui/sign_up_cubit.dart';
import 'package:sign_up_ui/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  final SignUpState state;

  const SignUpScreen({super.key, required this.state});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<SignUpCubit>();

    final formState = widget.state;
    String? emailError;
    String? passwordError;
    String? nicknameError;
    bool isSubmitting = false;
    String? signUpError;
    bool isCheckingNickname = false;
    bool? isNicknameAvailable;

    if (formState is SignUpFormState) {
      emailError = formState.emailError;
      passwordError = formState.passwordError;
      nicknameError = formState.nicknameError;
      isSubmitting = formState.isSubmitting;
      signUpError = formState.signUpError;
      isCheckingNickname = formState.isCheckingNickname;
      isNicknameAvailable = formState.isNicknameAvailable;
    }

    final isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nicknameController.text.isNotEmpty &&
        cubit.validateEmail(_emailController.text) == null &&
        cubit.validatePassword(_passwordController.text) == null &&
        cubit.validateNickname(_nicknameController.text) == null &&
        nicknameError == null &&
        !isSubmitting;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                if (signUpError != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _resolveSignUpError(signUpError, l10n),
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onErrorContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !isSubmitting,
                  decoration: InputDecoration(
                    labelText: l10n.loginEmail,
                    hintText: l10n.loginEmailHint,
                    errorText: _resolveEmailError(emailError, l10n),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  onChanged: (value) {
                    cubit.onEmailChanged(value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  enabled: !isSubmitting,
                  decoration: InputDecoration(
                    labelText: l10n.loginPassword,
                    hintText: l10n.loginPasswordHint,
                    errorText: _resolvePasswordError(passwordError, l10n),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.onPasswordChanged(value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nicknameController,
                  textInputAction: TextInputAction.done,
                  enabled: !isSubmitting,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: l10n.signUpNickname,
                    hintText: l10n.signUpNicknameHint,
                    errorText: _resolveNicknameError(nicknameError, l10n),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person_outlined),
                    suffixIcon: _buildNicknameSuffix(
                      isCheckingNickname,
                      isNicknameAvailable,
                      nicknameError,
                    ),
                  ),
                  onChanged: (value) {
                    cubit.onNicknameChanged(value);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: isFormValid && !isSubmitting
                  ? () => cubit.createAccount(
                        _emailController.text,
                        _passwordController.text,
                        _nicknameController.text,
                      )
                  : null,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.createAccountButton),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildNicknameSuffix(
    bool isChecking,
    bool? isAvailable,
    String? error,
  ) {
    if (isChecking) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (error != null) return null;
    if (isAvailable == true) {
      return const Icon(Icons.check_circle_outline, color: Colors.green);
    }
    return null;
  }

  String? _resolveEmailError(String? error, AppLocalizations l10n) =>
      switch (error) {
        'required' => l10n.fieldRequired,
        'invalid' => l10n.emailValidationError,
        _ => null,
      };

  String? _resolvePasswordError(String? error, AppLocalizations l10n) =>
      switch (error) {
        'required' => l10n.fieldRequired,
        'too_short' => l10n.passwordValidationError,
        'too_long' => l10n.passwordTooLongError,
        _ => null,
      };

  String? _resolveNicknameError(String? error, AppLocalizations l10n) =>
      switch (error) {
        'required' => l10n.nicknameValidationError,
        'too_long' => l10n.nicknameTooLongError,
        'taken' => l10n.nicknameTakenError,
        _ => null,
      };

  String _resolveSignUpError(String error, AppLocalizations l10n) =>
      switch (error) {
        'conflict' => l10n.signUpConflictError,
        'bad_request' => l10n.signUpBadRequestError,
        'network' => l10n.signUpNetworkError,
        'server' => l10n.signUpServerError,
        _ => l10n.loginGenericError,
      };
}
