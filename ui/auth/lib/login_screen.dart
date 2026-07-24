import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/common.dart';
import 'package:auth_ui/login_cubit.dart';
import 'package:auth_ui/login_state.dart';

class LoginScreen extends StatefulWidget {
  final LoginState state;
  final VoidCallback? onSignUpTap;

  const LoginScreen({
    super.key,
    required this.state,
    this.onSignUpTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => switch (widget.state) {
        LoginLoading() => _buildLoadingState(context),
        LoginAuthenticated() => _buildLoadingState(context),
        LoginUnauthenticated() => _buildEmailForm(context),
        LoginError(:final message) =>
          _buildEmailForm(context, loginError: message),
        LoginFormState(
          :final emailError,
          :final passwordError,
          :final isSubmitting,
          :final loginError,
        ) =>
          _buildEmailForm(
            context,
            emailError: emailError,
            passwordError: passwordError,
            isSubmitting: isSubmitting,
            loginError: loginError,
          ),
      };

  Widget _buildLoadingState(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildEmailForm(
    BuildContext context, {
    String? emailError,
    String? passwordError,
    bool isSubmitting = false,
    String? loginError,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<LoginCubit>();
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final isFormValid = emailError == null &&
        passwordError == null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Icon(
                  Icons.movie_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                  semanticLabel: null,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.appTitle,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.loginSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  enabled: !isSubmitting,
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
                  onChanged: (value) => cubit.onEmailChanged(value),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  enabled: !isSubmitting,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    if (isFormValid && !isSubmitting) {
                      cubit.loginWithEmail(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
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
                      onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  onChanged: (value) => cubit.onPasswordChanged(value),
                ),
                if (loginError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    loginError == 'invalid_credentials'
                        ? l10n.loginError
                        : l10n.loginGenericError,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: isFormValid && !isSubmitting
                      ? () => cubit.loginWithEmail(
                            _emailController.text,
                            _passwordController.text,
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
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.loginButton),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: isKeyboardOpen
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed:
                                isSubmitting ? null : widget.onSignUpTap,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(l10n.signUpButton),
                          ),
                        ),
                      ),
              ),
            ],
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
}
