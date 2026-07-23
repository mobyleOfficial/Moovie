import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/common.dart';
import 'package:auth_ui/login_cubit.dart';
import 'package:auth_ui/login_state.dart';

class LoginScreen extends StatefulWidget {
  final LoginState state;
  final VoidCallback? onClose;
  final VoidCallback? onSignUpTap;

  const LoginScreen({
    super.key,
    required this.state,
    this.onClose,
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
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: switch (widget.state) {
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
          },
        ),
      );

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
    final isFormValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        cubit.validateEmail(_emailController.text) == null &&
        cubit.validatePassword(_passwordController.text) == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.onClose != null)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onClose,
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              ),
            ),
          const Spacer(flex: 2),
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
          const Spacer(),
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
            onChanged: (_) => setState(() {}),
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
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (loginError != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                loginError,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 24),
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
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.loginButton),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: isSubmitting ? null : widget.onSignUpTap,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(l10n.signUpButton),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
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
