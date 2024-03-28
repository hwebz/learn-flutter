import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp(UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));

      res.fold((l) => emit(AuthFailure(message: l.message)),
          (uid) => emit(AuthSuccess(uid: uid)));
    });
  }
}
