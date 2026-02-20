import 'package:flutter/material.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_button.dart';

class StockOutward extends StatelessWidget {
  const StockOutward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Stock Outward"),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppDropDown(label: "Item", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,),
        SizedBox(height: 10,),
        AppTextField(labelText: "Quantity",),
        SizedBox(height: 10,),
        AppDropDown(label: "Recipient Type", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,),
        SizedBox(height: 10,),
        AppTextField(labelText: "Notes",maxLines: 3,),
        SizedBox(height: 10,),
        AppButton(text: "Submit",color: Color(0xFF8EBF1F),)
      ],),
    ),);
  }
}
