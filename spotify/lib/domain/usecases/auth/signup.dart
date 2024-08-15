import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}
