import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/admin_notification_model.dart';

class NotificationController extends GetxController {
  ApiService apiService = ApiService();

  bool isNotificationLoading = false;
  List<NotificationDatum> notificationList = [];
  List<NotificationDatum> notificationFilterList = [];

  @override
  void onInit() {
    super.onInit();
    getNotificationApi();
  }

  /// Filter: unread only
  void filterUnread() {
    notificationFilterList = notificationList
        .where((e) => e.isRead == false)
        .toList();
    update();
  }

  /// Filter: all
  void filterAll() {
    notificationFilterList = List.from(notificationList);
    update();
  }

  Future<void> getNotificationApi() async {
    isNotificationLoading = true;
    update();

    final response = await apiService.get(AppUrl.getNotificationsUrl);

    if (response != null && response["success"] == true) {
      final AdminNotificationModel model = AdminNotificationModel.fromMap(
        response,
      );
      notificationList = model.data ?? [];
      notificationFilterList = List.from(notificationList);
    } else {
      AppToast.error();
    }

    isNotificationLoading = false;
    update();
  }
}
