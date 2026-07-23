import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:sign_up_ui/sign_up.dart';

void main() {
  SignUpCubit buildCubit() => SignUpCubit();

  group('createAccount', () {
    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpSuccess] when all fields valid',
      build: buildCubit,
      act: (cubit) =>
          cubit.createAccount('test@example.com', 'password123', 'nick'),
      expect: () => [isA<SignUpSuccess>()],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpFormState with emailError] for invalid email',
      build: buildCubit,
      act: (cubit) =>
          cubit.createAccount('invalid', 'password123', 'nick'),
      expect: () => [
        isA<SignUpFormState>().having(
          (s) => s.emailError,
          'emailError',
          isNotNull,
        ),
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpFormState with passwordError] for short password',
      build: buildCubit,
      act: (cubit) =>
          cubit.createAccount('test@example.com', '12345', 'nick'),
      expect: () => [
        isA<SignUpFormState>().having(
          (s) => s.passwordError,
          'passwordError',
          isNotNull,
        ),
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpFormState with nicknameError] for empty nickname',
      build: buildCubit,
      act: (cubit) =>
          cubit.createAccount('test@example.com', 'password123', ''),
      expect: () => [
        isA<SignUpFormState>().having(
          (s) => s.nicknameError,
          'nicknameError',
          isNotNull,
        ),
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits all validation errors when all fields invalid',
      build: buildCubit,
      act: (cubit) => cubit.createAccount('', '', ''),
      expect: () => [
        isA<SignUpFormState>()
            .having((s) => s.emailError, 'emailError', isNotNull)
            .having((s) => s.passwordError, 'passwordError', isNotNull)
            .having((s) => s.nicknameError, 'nicknameError', isNotNull),
      ],
    );
  });

  group('validation', () {
    test('validateEmail returns null for valid email', () {
      final cubit = buildCubit();
      expect(cubit.validateEmail('test@example.com'), isNull);
    });

    test('validateEmail returns required for empty', () {
      final cubit = buildCubit();
      expect(cubit.validateEmail(''), 'required');
    });

    test('validateEmail returns invalid for bad format', () {
      final cubit = buildCubit();
      expect(cubit.validateEmail('no-at-sign'), 'invalid');
    });

    test('validatePassword returns null for valid password', () {
      final cubit = buildCubit();
      expect(cubit.validatePassword('123456'), isNull);
    });

    test('validatePassword returns required for empty', () {
      final cubit = buildCubit();
      expect(cubit.validatePassword(''), 'required');
    });

    test('validatePassword returns too_short for < 6 chars', () {
      final cubit = buildCubit();
      expect(cubit.validatePassword('12345'), 'too_short');
    });

    test('validateNickname returns null for non-empty', () {
      final cubit = buildCubit();
      expect(cubit.validateNickname('nick'), isNull);
    });

    test('validateNickname returns required for empty', () {
      final cubit = buildCubit();
      expect(cubit.validateNickname(''), 'required');
    });
  });
}
