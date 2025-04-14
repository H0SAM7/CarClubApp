part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure({required this.errMessage});
}

final class AuthLoading extends AuthState {}
final class AuthCancel extends AuthState {}

final class AuthSendVerification extends AuthState {}

final class AuthVerificationFailure extends AuthState {
 String errMessage='Email verification failed.';
}



