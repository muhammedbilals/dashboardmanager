import 'package:bloc/bloc.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:dashboard/main.dart';
import 'package:dashboard/presentation/cubit/auth_cubit/auth_state.dart';



import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(LoginRequest loginRequest) async {
    emit(AuthLoading());
    final result = await authRepository.login(logInRequest: loginRequest);
    if(result.isRight){
      localDb.setString("jwtKey", result.right.tokens);
      localDb.setString("userRole", result.right.userRole);

    }
    result.fold(
      (failure) => emit(AuthFailure("Login Failed")),
      (login) => emit(AuthSuccess('Login successful!',login.userRole)),
    );
  }

  Future<void> register(RegistraionRequest registrationRequest) async {
    emit(AuthLoading());
    final result = await authRepository.registration(signUpRequest: registrationRequest);
    if(result.isRight){
      localDb.setString("jwtKey", result.right.tokens!);
      localDb.setString("userRole", result.right.userRole!);

    }
    result.fold(
      (failure) => emit(AuthFailure("Registration Failed")),
      (user) => emit(AuthSuccess('Registration successful!',user.userRole!)),
    );
  }
}
