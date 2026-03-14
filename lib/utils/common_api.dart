import 'package:purosis/feature/admin/marketing/model/detail_model.dart';
import 'package:purosis/utils/api_service.dart';

import '../consts/app_url.dart';
import 'app_toast.dart';

class CommonApi {
  final ApiService _apiService = ApiService();

  Future<DetailModel> getDetailApi() async {
    DetailModel detailModel = DetailModel();
    await _apiService
        .get(AppUrl.getDetailsUrl)
        .then((response) {
          if (response["success"] == true) {
            detailModel = DetailModel.fromJson(response["data"]);
          }
        })
        .catchError((value) {
          AppToast.error();
        });
    return detailModel;
  }
}
