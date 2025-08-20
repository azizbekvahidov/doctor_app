import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  AuthController(this.authRepository);

  login() {}
  register() {}
  logout() {}
}
