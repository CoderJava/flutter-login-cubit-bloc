import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login_cubit_bloc/login_cubit.dart';
import 'package:flutter_login_cubit_bloc/login_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginCubit loginCubit;

  setUp(() {
    loginCubit = LoginCubit();
  });

  tearDown(() {
    loginCubit?.close();
  });

  blocTest(
    'pastikan emit [LoadingLoginState, SuccessLoginState] ketika terima argumen '
    'username admin dan password admin',
    build: () {
      return loginCubit;
    },
    act: (cubit) {
      return cubit.login('admin', 'admin');
    },
    expect: [
      LoadingLoginState(),
      SuccessLoginState(),
    ],
  );

  blocTest(
    'pastikan emit [LoadingLoginState, FailureLoginState] ketika terima argumen '
    'username != admin dan password != admin',
    build: () {
      return loginCubit;
    },
    act: (cubit) {
      return cubit.login('admin2', 'admin2');
    },
    expect: [
      LoadingLoginState(),
      FailureLoginState('Login failure'),
    ],
  );
}
