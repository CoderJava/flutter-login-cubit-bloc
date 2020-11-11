import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_cubit_bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  void login(String username, String password) async {
    emit(LoadingLoginState());
    await Future.delayed(Duration(seconds: 3));
    if (username == 'admin' && password == 'admin') {
      emit(SuccessLoginState());
    } else {
      emit(FailureLoginState('Login failure'));
    }
  }
}
