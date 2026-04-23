import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:purosis/consts/storage_keys.dart';
import 'package:purosis/feature/admin/profile/model/activity_log_model.dart';
import 'package:purosis/feature/admin/profile/model/query/update_profile_query.dart';
import 'package:purosis/feature/admin/profile/model/support_message_model.dart';
import 'package:purosis/feature/admin/profile/model/support_model.dart';
import 'package:purosis/feature/auth/model/user_model.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/commmon_function.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';
import '../model/added_user_model.dart';
import '../model/query/activity_log_query.dart';
import '../model/query/update_support_query.dart';
import '../model/query/update_user_status_query.dart';

class AdminProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  ApiService apiService = ApiService();
  UserModel? userModel;
  TextEditingController adminNameTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();
  GlobalKey<FormState> validationKey = GlobalKey();
  bool isUpdateProfileLoading = false;
  bool isUserLoading = false;
  List<AddedUserModel> addUserModelList = [];
  List<AddedUserModel> addUserModelFilterList = [];
  List<SupportMessageModel> supportMessageModelList = [];
  List<ActivityLogModel> activityLogModelList = [];
  List<ActivityLogModel> activityLogModelFilterList = [];
  bool isUpdateSupportLoading = false;
  bool isSupportLoading = false;
  bool isUpdateUserStatusLoading = false;
  bool isSupportMessageLoading = false;
  bool isLogDataLoading = false;
  int? selectedUserId;
  SupportModel? supportModel;
  File? selectedFile;
  final List<LatLng> locations = [];
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  String selectedLogTypeValue = "Both";
  List<String> logTypeList = ["App Open", "Orders", "Both"];
  final List<String> daysFiltersList = ["Today", "7 Days", "30 Days", "Custom"];
  int? selectedMarkerId;
  String? selectedMarkerCity;
  String selectedDaysValue = "Custom";

  TextEditingController mobileNumberSupportTEC = TextEditingController();
  TextEditingController officeTimeSupportTEC = TextEditingController();
  TextEditingController emailAddressSupportTEC = TextEditingController();
  TextEditingController notesSupportTEC = TextEditingController();
  GlobalKey<FormState> validationKeySupport = GlobalKey<FormState>();

  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
    adminNameTEC.text = userModel?.name ?? "";
    mobileNumberTEC.text = userModel?.phoneNo ?? "";
    emailAddressTEC.text = userModel?.email ?? "";
  }

  resetValue() {
    selectedDaysValue = "All";
    selectedMarkerId = null;
    selectedLogTypeValue = "Both";
  }

  // filterMarker(){
  //   if(selectValue == radioList[0]){
  //     activityLogModelFilterList = activityLogModelList.where((e)=>e.eventType == "login").toList();
  //     selectedMarkerId=null;
  //     addMarkers();
  //   }else if(selectValue == radioList[1]){
  //     activityLogModelFilterList = activityLogModelList.where((e)=>e.eventType == "order").toList();
  //     selectedMarkerId=null;
  //     addMarkers();
  //   }else{
  //     activityLogModelFilterList = activityLogModelList;
  //     selectedMarkerId=null;
  //     addMarkers();
  //   }
  //   update();
  // }

  void filterMarker() {
    final now = DateTime.now();

    activityLogModelFilterList = activityLogModelList.where((e) {
      bool matchEvent = true;

      if (selectedLogTypeValue == logTypeList[0]) {
        matchEvent = e.eventType == "login";
      } else if (selectedLogTypeValue == logTypeList[1]) {
        matchEvent = e.eventType == "order";
      }

      DateTime itemDate = DateTime.parse(
        e.createdAt!.replaceFirst(' ', 'T'),
      ).toLocal();

      bool matchDate = true;

      if (selectedDaysValue == "Today") {
        matchDate =
            itemDate.year == now.year &&
            itemDate.month == now.month &&
            itemDate.day == now.day;
      } else if (selectedDaysValue == "7 Days") {
        final sevenDaysAgo = now.subtract(Duration(days: 7));
        matchDate = !itemDate.isBefore(sevenDaysAgo);
      } else if (selectedDaysValue == "30 Days") {
        final thirtyDaysAgo = now.subtract(Duration(days: 30));
        matchDate = !itemDate.isBefore(thirtyDaysAgo);
      } else {
        matchDate = true;
      }

      return matchEvent && matchDate;
    }).toList();
    selectedMarkerId = null;
    addMarkers();
    update();
  }

  void addMarkers() {
    markers.clear();
    for (int i = 0; i < activityLogModelFilterList.length; i++) {
      if (activityLogModelFilterList[i].latitude == null ||
          activityLogModelFilterList[i].longitude == null) {
        continue;
      }
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(
            double.tryParse(activityLogModelFilterList[i].latitude ?? "") ?? 0,
            double.tryParse(activityLogModelFilterList[i].longitude ?? "") ?? 0,
          ),
          infoWindow: InfoWindow(
            title: activityLogModelFilterList[i].eventType,
            snippet: CommonFunction.convertUtcToLocalFormatted(
              activityLogModelFilterList[i].eventAt ?? "",
            ).split(",").firstOrNull,
          ),
          onTap: () async {
            selectedMarkerId = i;
            selectedMarkerCity =
                await getAddressFromLatLng(
                  double.tryParse(
                        activityLogModelFilterList[selectedMarkerId ?? 0]
                                .latitude ??
                            "0.0",
                      ) ??
                      0.0,
                  double.tryParse(
                        activityLogModelFilterList[selectedMarkerId ?? 0]
                                .longitude ??
                            "0.0",
                      ) ??
                      0.0,
                ) ??
                "";
            update();
          },
        ),
      );
    }
    update();
  }

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String city = place.locality ?? '';
        String country = place.country ?? '';
        print("$city , $country");
        return "$city , $country";
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }

  getUserStatus(value) {
    if (value == 1) {
      return "Active";
    } else {
      return "Deactivate";
    }
  }

  searchUser(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = addUserModelList
          .where(
            (item) =>
                (item.name?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (item.phoneNo?.contains(query) ?? false),
          )
          .toList();
      addUserModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      addUserModelFilterList = addUserModelList;
      update();
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      allowMultiple: false,
    );
    if (result != null) {
      selectedFile = File(result.files.first.path ?? "");
      update();
    }
  }

  Future<void> updateProfileApi() async {
    isUpdateProfileLoading = true;
    update();
    UpdateProfileQuery updateProfileQuery = UpdateProfileQuery(
      name: adminNameTEC.text,
      phoneNo: mobileNumberTEC.text,
      email: emailAddressTEC.text,
      profilePhoto: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.updateAdminProfileUrl,
          updateProfileQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            final oldData = storage.read(StorageKeys.userData) ?? {};
            final Map<String, dynamic> mergedData = {
              ...oldData,
              ...response["data"],
            };
            final UserModel userModel = UserModel.fromJson(mergedData);
            storage.write(StorageKeys.userData, userModel.toJson());
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isUpdateProfileLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isUpdateProfileLoading = false;
          update();
        });
  }

  Future<void> getUserApi() async {
    isUserLoading = true;
    // update();
    await apiService
        .get(AppUrl.getUserUrl)
        .then((response) {
          if (response["success"] == true) {
            addUserModelList.clear();
            addUserModelFilterList.clear();
            for (final data in response["data"]) {
              addUserModelList.add(AddedUserModel.fromJson(data));
              addUserModelFilterList.add(AddedUserModel.fromJson(data));
            }
            isUserLoading = false;
            update();
          }
        })
        .catchError((value) {
          isUserLoading = false;
          update();
        });
  }

  Future<void> getSupportDetailApi() async {
    isSupportLoading = true;
    // update();
    await apiService
        .get(AppUrl.getSupportDetailsUrl)
        .then((response) {
          if (response["success"] == true) {
            supportModel = SupportModel.fromJson(response["data"]);
            mobileNumberSupportTEC.text = supportModel?.phoneNo ?? "";
            officeTimeSupportTEC.text = supportModel?.officeTimings ?? "";
            emailAddressSupportTEC.text = supportModel?.email ?? "";
            notesSupportTEC.text = supportModel?.note ?? "";
            isSupportLoading = false;
            update();
          }
        })
        .catchError((value) {
          isSupportLoading = false;
          update();
        });
  }

  Future<void> updateSupportDetailApi() async {
    isUpdateSupportLoading = true;
    update();
    UpdateSupportQuery updateSupportQuery = UpdateSupportQuery(
      phoneNo: mobileNumberSupportTEC.text,
      email: emailAddressSupportTEC.text,
      officeTimings: officeTimeSupportTEC.text,
      note: notesSupportTEC.text,
    );
    await apiService
        .postFormData(
          AppUrl.updateSupportDetailUrl,
          updateSupportQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back();
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isUpdateSupportLoading = false;
          update();
        })
        .catchError((value) {
          isUpdateSupportLoading = false;
          update();
        });
  }

  Future<void> getSupportMessageApi() async {
    isSupportMessageLoading = true;
    // update();
    await apiService
        .get(AppUrl.getSupportMessageUrl)
        .then((response) {
          supportMessageModelList.clear();
          if (response["success"] == true) {
            for (final data in response["data"]) {
              supportMessageModelList.add(SupportMessageModel.fromJson(data));
            }
          }
          isSupportMessageLoading = false;
          update();
        })
        .catchError((value) {
          isSupportMessageLoading = false;
          update();
        });
  }

  Future<void> updateUserStatusApi(int? userId, int? status) async {
    isUpdateUserStatusLoading = true;
    selectedUserId = userId;
    update();
    UpdateUserStatusQuery updateUserStatusQuery = UpdateUserStatusQuery(
      distributorId: userId,
      status: status,
    );
    await apiService
        .postFormData(
          AppUrl.updateUserStatusUrl,
          updateUserStatusQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            addUserModelList[addUserModelList.indexWhere((e) => e.id == userId)]
                    .isActive =
                status;
            addUserModelFilterList[addUserModelFilterList.indexWhere(
                      (e) => e.id == userId,
                    )]
                    .isActive =
                status;
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          selectedUserId = null;
          isUpdateUserStatusLoading = false;
          update();
        })
        .catchError((value) {
          isUpdateUserStatusLoading = false;
          update();
        });
  }

  Future<void> userMapDetailApi(AddedUserModel userDataModel) async {
    isLogDataLoading = true;
    // update();
    activityLogModelList.clear();
    activityLogModelFilterList.clear();
    ActivityLogQuery activityLogQuery = ActivityLogQuery(
      actorId: userDataModel.id,
      userType: "distributor",
    );
    await apiService
        .postFormData(AppUrl.activityLogsUrl, activityLogQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            for (final data in response["data"]) {
              activityLogModelList.add(ActivityLogModel.fromJson(data));
              activityLogModelFilterList.add(ActivityLogModel.fromJson(data));
            }
            addMarkers();
          } else {
            AppToast.error();
          }
          selectedUserId = null;
          isLogDataLoading = false;
          update();
        })
        .catchError((value) {
          isLogDataLoading = false;
          update();
        });
  }
}
