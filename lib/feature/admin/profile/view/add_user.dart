import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/add_user_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/app_text_field.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add User"),
      body: GetBuilder<AddUserController>(
        init: AddUserController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              key: controller.validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: controller.selectedFile != null
                                ? Image.file(controller.selectedFile!)
                                : Image.asset(
                                    AppImage.imageIcon,
                                    color: Colors.grey,
                                  ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pickFile();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.upload, color: Colors.grey),
                                      AppText(
                                        text: "Upload Logo",
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 3),
                              AppText(
                                text:
                                    "Your logo will appear on marketing\nmaterials you customize",
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AppText(
                      text: "Basic Information",
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          AppTextField(
                            labelText: "Company Name",
                            controller: controller.companyNameTEC,
                            validator: CommonValidation.fieldValidation,
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "Contact Person Name",
                            controller: controller.contactPersonNameTEC,
                            validator: CommonValidation.fieldValidation,
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "GST Number",
                            controller: controller.gstNumberTEC,
                            validator: CommonValidation.fieldValidation,
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "Area",
                            controller: controller.areaTEC,
                            validator: CommonValidation.fieldValidation,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AppText(
                      text: "Contact Information",
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          AppTextField(
                            labelText: "Mobile Number",
                            controller: controller.phoneNoTEC,
                            validator: CommonValidation.fieldValidation,
                            keyboardType: TextInputType.number,
                            inputFormatter:
                                CommonValidation.inputValidationOnlyNumber(
                                  maxLength: 10,
                                ),
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "Alternate Mobile Number",
                            controller: controller.alternatePhoneNoTEC,
                            validator: CommonValidation.fieldValidation,
                            keyboardType: TextInputType.number,
                            inputFormatter:
                                CommonValidation.inputValidationOnlyNumber(
                                  maxLength: 10,
                                ),
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "Landline Number",
                            controller: controller.landlinePhoneNoTEC,
                            validator: CommonValidation.fieldValidation,
                            keyboardType: TextInputType.number,
                            inputFormatter:
                                CommonValidation.inputValidationOnlyNumber(
                                  maxLength: 10,
                                ),
                          ),
                          SizedBox(height: 5),
                          AppTextField(
                            labelText: "Email",
                            controller: controller.emailTEC,
                            validator: CommonValidation.isValidEmail,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0),
                  //   child: AppText(
                  //     text: "Addresses",
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  // Card(
                  //   color: Colors.white,
                  //   margin: EdgeInsets.all(10),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         SizedBox(height: 10),
                  //         AppTextField(
                  //           labelText: "Billing Address",
                  //           controller: controller.billingAddressTEC,
                  //           validator: CommonValidation.fieldValidation,
                  //         ),
                  //         SizedBox(height: 5),
                  //         AppTextField(
                  //           labelText: "PINCode",
                  //           controller: controller.pinCodeTEC,
                  //           validator: CommonValidation.fieldValidation,
                  //           inputFormatter:
                  //               CommonValidation.inputValidationOnlyNumber(
                  //                 maxLength: 6,
                  //               ),
                  //         ),
                  //         SizedBox(height: 5),
                  //         AppText(text: "Shipping Address"),
                  //         SizedBox(height: 5),
                  //         Row(
                  //           children: [
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: controller.typeList.map((type) {
                  //                 return Row(
                  //                   children: [
                  //                     Radio<String>(
                  //                       value: type,
                  //                       groupValue: controller.selectedType,
                  //                       onChanged: (value) {
                  //                         controller.selectedType = value ?? '';
                  //                         controller.update();
                  //                       },
                  //                     ),
                  //                     AppText(text: type),
                  //                     const SizedBox(width: 10),
                  //                   ],
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ],
                  //         ),
                  //         Visibility(
                  //           visible:
                  //               controller.selectedType !=
                  //               "Same as Billing Address",
                  //           child: Column(
                  //             children: [
                  //               SizedBox(height: 5),
                  //               AppTextField(
                  //                 labelText: "Complete Shipping Address",
                  //                 controller: controller.shippingAddressTEC,
                  //                 validator: CommonValidation.fieldValidation,
                  //               ),
                  //               SizedBox(height: 5),
                  //               AppTextField(
                  //                 labelText: "PINCode",
                  //                 controller: controller.shippingPINCodeTEC,
                  //                 validator: CommonValidation.fieldValidation,
                  //                 inputFormatter:
                  //                     CommonValidation.inputValidationOnlyNumber(
                  //                       maxLength: 6,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         SizedBox(height: 10),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      onPressed: () {
                        if (controller.validationKey.currentState?.validate() ??
                            false) {
                          controller.addUserApi();
                        }
                      },
                      isLoading: controller.isLoading,
                      text: "Add User",
                      color: Color(0xFF8EBF1F),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
