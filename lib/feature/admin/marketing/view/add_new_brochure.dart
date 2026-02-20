import 'package:flutter/material.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_image_upload.dart';
import '../../../../widget/app_text_field.dart';

class AddNewBrochure extends StatelessWidget {
  const AddNewBrochure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Add New Brochure"),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppTextField(labelText: "Title",),
        SizedBox(height: 10,),
        AppTextField(labelText: "Category",),
        SizedBox(height: 10,),
        AppImageUpload(onFileSelected: (value) {

        },),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: AppDropDown(label: "Month", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,)),
            SizedBox(width: 10,),
            Expanded(child: AppDropDown(label: "Year", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,)),
          ],
        ),
        SizedBox(height: 10,),
        AppTextField(labelText: "Description",maxLines: 3,),
        SizedBox(height: 10,),
        AppButton(text: "Upload",color: Color(0xFF8EBF1F),)
      ],),
    ),);
  }
}
