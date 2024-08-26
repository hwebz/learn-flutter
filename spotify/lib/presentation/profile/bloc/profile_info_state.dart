import 'package:spotify/domain/entities/auth/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity user;

  ProfileInfoLoaded({required this.user});
}

class ProfileInfoFailure extends ProfileInfoState {}
