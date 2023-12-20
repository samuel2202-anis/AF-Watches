import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String name;
  final String email;
  final String password;

  const AppUser(
      {required this.name,
      required this.email,
      required this.password});

  factory AppUser.fromMap(data) => AppUser(
      name: data['name'],
      email: data['email'],
      password: data['password']);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
