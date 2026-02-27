import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/utils/commmon_function.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

class AdminProfileEdit extends StatefulWidget {
  const AdminProfileEdit({super.key});

  @override
  State<AdminProfileEdit> createState() => _AdminProfileEditState();
}

class _AdminProfileEditState extends State<AdminProfileEdit> {
  AdminProfileController adminProfileController = AdminProfileController();
  @override
  void initState() {
    adminProfileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: 'My Profile'),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  AppTextField(
                    labelText: "Admin Name",
                    controller: controller.adminNameTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Mobile Number",
                    controller: controller.mobileNumberTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Email Address",
                    controller: controller.emailAddressTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 20),
                  AppButton(
                    text: "Save Profile",
                    color: Color(0xFF8EBF1F),
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.updateProfileApi();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
