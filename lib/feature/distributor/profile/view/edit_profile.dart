import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final List<String> typeList = [
    "Same as Billing Address",
    "Add New Shipping Address",
  ];
  final String selectedType = "Add New Shipping Address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(height: 100, width: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.upload, color: Colors.grey),
                              AppText(text: "Upload Logo", color: Colors.grey),
                            ],
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    AppTextField(labelText: "Company Name"),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Contact Person Name"),
                    SizedBox(height: 5),
                    AppTextField(labelText: "GST Number"),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Area/Region"),
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
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    AppTextField(labelText: "Enter Mobile Number"),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Enter Alternate Mobile Number"),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Landline Number "),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Enter Email Address"),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AppText(
                text: "Addresses",
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    AppTextField(labelText: "Billing Address"),
                    SizedBox(height: 5),
                    AppText(text: "Shipping Address"),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: typeList.map((type) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: type,
                                  groupValue: selectedType,
                                  onChanged: (value) {},
                                ),
                                AppText(text: type),
                                const SizedBox(width: 10),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    AppTextField(labelText: "Complete Shipping Address"),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(text: "Save Profile", color: Color(0xFF8EBF1F)),
            ),
          ],
        ),
      ),
    );
  }
}
