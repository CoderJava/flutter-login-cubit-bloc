
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_cubit_bloc/login_state.dart';

import 'login_bloc.dart';
import 'login_event.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final formState = GlobalKey<FormState>();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is FailureLoginState) {
              scaffoldState.currentState.showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is SuccessLoginState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
            }
          },
          child: Stack(
            children: [
              Form(
                key: formState,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerUsername,
                        decoration: InputDecoration(
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          return value.isEmpty ? 'Username is empty' : null;
                        },
                      ),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) => value.isEmpty ? 'Password is empty' : null,
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('LOGIN'),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () {
                            if (formState.currentState.validate()) {
                              var username = controllerUsername.text.trim();
                              var password = controllerPassword.text.trim();
                              loginBloc.add(SubmitLoginEvent(username, password));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoadingLoginState) {
                    return Container(
                      color: Colors.black.withOpacity(.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Login Success'),
      ),
    );
  }
}

