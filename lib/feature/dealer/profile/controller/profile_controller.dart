import 'package:get/get.dart';

import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/user_model.dart';

class ProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  UserModel? userModel;
  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }
}
