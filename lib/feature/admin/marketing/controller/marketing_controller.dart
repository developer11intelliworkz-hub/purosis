import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../model/brochures_model.dart';

class MarketingController extends GetxController {
  ApiService apiService = ApiService();
  bool isBrochuresLoading = false;
  List<BrochuresModel> brochuresModelList = [];

  Future<List<BrochuresModel>> getBrochuresApi() async {
    isBrochuresLoading = true;
    update();
    await apiService
        .get(AppUrl.getBrochuresUrl)
        .then((response) {
          if (response["success"] == true) {
            brochuresModelList.clear();
            for (final data in response['data']) {
              brochuresModelList.add(BrochuresModel.fromJson(data));
            }
            isBrochuresLoading = false;
            update();
          }
        })
        .catchError((value) {
          isBrochuresLoading = false;
          update();
        });
    return brochuresModelList;
  }
}
