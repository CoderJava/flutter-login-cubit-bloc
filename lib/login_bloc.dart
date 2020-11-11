import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_cubit_bloc/login_state.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLoginEvent) {
      yield LoadingLoginState();
      await Future.delayed(Duration(seconds: 3));
      if (event.username == 'admin' && event.password == 'admin') {
        yield SuccessLoginState();
      } else {
        yield FailureLoginState('Login failure');
      }
    }
  }
}
