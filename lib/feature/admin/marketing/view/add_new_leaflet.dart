import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_image_upload.dart';

class AddNewLeaflet extends StatelessWidget {
  const AddNewLeaflet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add New Leaflet"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextField(labelText: "Title"),
            SizedBox(height: 10),
            AppTextField(labelText: "Category"),
            SizedBox(height: 10),
            AppImageUpload(onFileSelected: (value) {}),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AppDropDown(
                    label: "Month",
                    items: (p0, p1) => [],
                    compareFn: (p0, p1) => p0 == p1,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AppDropDown(
                    label: "Year",
                    items: (p0, p1) => [],
                    compareFn: (p0, p1) => p0 == p1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            AppTextField(labelText: "Description", maxLines: 3),
            SizedBox(height: 10),
            AppButton(text: "Upload", color: Color(0xFF8EBF1F)),
          ],
        ),
      ),
    );
  }
}
