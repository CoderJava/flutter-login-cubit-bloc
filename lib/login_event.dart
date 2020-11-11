import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class SubmitLoginEvent extends LoginEvent {
  final String username;
  final String password;

  SubmitLoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'SubmitLoginEvent{username: $username, password: $password}';
  }
}