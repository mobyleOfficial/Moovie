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

    if (formState is SignUpFormState) {
      emailError = formState.emailError;
      passwordError = formState.passwordError;
      nicknameError = formState.nicknameError;
    }

    final isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nicknameController.text.isNotEmpty &&
        cubit.validateEmail(_emailController.text) == null &&
        cubit.validatePassword(_passwordController.text) == null &&
        cubit.validateNickname(_nicknameController.text) == null;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.loginEmail,
                        hintText: l10n.loginEmailHint,
                        errorText: _resolveEmailError(emailError, l10n),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.loginPassword,
                        hintText: l10n.loginPasswordHint,
                        errorText:
                            _resolvePasswordError(passwordError, l10n),
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
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nicknameController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.signUpNickname,
                        hintText: l10n.signUpNicknameHint,
                        errorText:
                            _resolveNicknameError(nicknameError, l10n),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person_outlined),
                      ),
                      onChanged: (_) => setState(() {}),
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
                  onPressed: isFormValid
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
                  child: Text(l10n.createAccountButton),
                ),
              ),
            ),
      ],
    );
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
        _ => null,
      };

  String? _resolveNicknameError(String? error, AppLocalizations l10n) =>
      switch (error) {
        'required' => l10n.nicknameValidationError,
        _ => null,
      };
}
