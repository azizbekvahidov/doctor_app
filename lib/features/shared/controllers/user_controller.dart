import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:get/get.dart';

import '../../auth/domain/models/user.dart';

class UserController extends GetxController {
  Rxn<User> user = Rxn(null);

  SecureStorageService storage = SecureStorageService();

  setUser(User newUser) async {
    user.value = newUser;
    await storage.saveUser(newUser.toRawJson());
  }

  getUser() async {
    user.value = await storage.getUser();
  }
}
