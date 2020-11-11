import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login_cubit_bloc/login_bloc.dart';
import 'package:flutter_login_cubit_bloc/login_event.dart';
import 'package:flutter_login_cubit_bloc/login_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginBloc loginBloc;

  setUp(() {
    loginBloc = LoginBloc();
  });

  tearDown(() {
    loginBloc?.close();
  });

  blocTest(
    'pastikan yield [LoadingLoginState, SuccessLoginState] ketika terima event '
    'SubmitLoginEvent dengan proses berhasil login',
    build: () {
      return loginBloc;
    },
    act: (bloc) {
      return bloc.add(SubmitLoginEvent('admin', 'admin'));
    },
    expect: [
      LoadingLoginState(),
      SuccessLoginState(),
    ],
  );

  blocTest(
    'pastikan yield [LoadingLoginState, FailureLoginState] ketika terima event '
    'SubmitLoginEvent dengan proses gagal login',
    build: () {
      return loginBloc;
    },
    act: (bloc) {
      return bloc.add(SubmitLoginEvent('admin2', 'admin2'));
    },
    expect: [
      LoadingLoginState(),
      FailureLoginState('Login failure'),
    ],
  );
}
