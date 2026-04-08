import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/utils/commmon_function.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_radio_button.dart';
import '../model/added_user_model.dart';

class UserActivityLocation extends StatefulWidget {
  const UserActivityLocation({super.key});

  @override
  State<UserActivityLocation> createState() => _UserActivityLocationState();
}

class _UserActivityLocationState extends State<UserActivityLocation> {
  final AdminProfileController adminProfileController = Get.find();
  final AddedUserModel data = Get.arguments;

  @override
  void initState() {
    adminProfileController.userMapDetailApi(data);
    super.initState();
  }

  @override
  void dispose() {
    adminProfileController.resetValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "company Name"),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.daysFiltersList.map((value) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          value,
                          style: TextStyle(
                            color: controller.selectedDaysValue == value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        showCheckmark: false,
                        selected: controller.selectedDaysValue == value,
                        selectedColor: Color(0xFF8EBF1F),
                        backgroundColor: Colors.grey.shade200,
                        onSelected: (isSelected) {
                          setState(() {
                            controller.selectedDaysValue = value;
                            controller.filterMarker();
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: controller.logTypeList
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppRadioButton(
                          value: e,
                          groupValue: controller.selectedLogTypeValue,
                          onChanged: (value) {
                            controller.selectedLogTypeValue = value;
                            controller.filterMarker();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 4.8,
                  ),
                  markers: controller.markers,
                  onMapCreated: (mapCnt) {
                    controller.mapController = mapCnt;
                  },
                ),
              ),
              SizedBox(
                height: 150,
                child: controller.isLogDataLoading
                    ? CommonWidget.commonLoading()
                    : controller.activityLogModelFilterList.isEmpty
                    ? CommonWidget.commonEmpty()
                    : controller.selectedMarkerId == null
                    ? Center(child: AppText(text: "Select Any Mark"))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text:
                                  controller
                                      .activityLogModelFilterList[controller
                                              .selectedMarkerId ??
                                          0]
                                      .eventType ??
                                  "",
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            AppText(text: "Mumbai,India", fontSize: 10),
                            Divider(),
                            AppText(
                              text:
                                  "Date: ${CommonFunction.convertUtcToLocalFormatted(controller.activityLogModelFilterList[controller.selectedMarkerId ?? 0].eventAt ?? "").split(",").firstOrNull ?? ""}",
                            ),
                            AppText(
                              text:
                                  "Time: ${CommonFunction.convertUtcToLocalFormatted(controller.activityLogModelFilterList[controller.selectedMarkerId ?? 0].eventAt ?? "").split(",").reversed.firstOrNull ?? ""}",
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
