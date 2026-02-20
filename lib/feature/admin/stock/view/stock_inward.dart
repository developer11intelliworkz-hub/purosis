import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

class StockInward extends StatelessWidget {
  const StockInward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Stock Inward"),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppTextField(labelText: "Item",),
        SizedBox(height: 10,),
        AppTextField(labelText: "Quantity",),
        SizedBox(height: 10,),
        AppTextField(labelText: "Notes",maxLines: 4,),
        SizedBox(height: 10,),
        AppButton(text: "Submit",color: Color(0xFF8EBF1F),)
      ],),
    ),);
  }
}
