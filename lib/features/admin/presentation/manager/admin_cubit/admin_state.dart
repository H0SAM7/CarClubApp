part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminSuccess extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminFailure extends AdminState {
  final String errMessage;

  AdminFailure({required this.errMessage});
}
