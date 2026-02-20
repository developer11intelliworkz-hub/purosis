import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text_field.dart';

import '../../../../widget/app_text.dart';


class AddNewAddress extends StatelessWidget {
   AddNewAddress({super.key});
  final List<String> typeList=["Same as Billing Address","Add New Shipping Address"];
  final String selectedType="Add New Shipping Address";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppTextField(labelText: "Dealer Name",),
        SizedBox(height: 5,),
        AppTextField(labelText: "Contact Person Name",),
        SizedBox(height: 5,),
        AppTextField(labelText: "GST Number",),
        SizedBox(height: 5,),
        AppTextField(labelText: "Billing Address",),
        SizedBox(height: 5,),
        AppDropDown(label: "State", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,),
        SizedBox(height: 5,),
        AppDropDown(label: "City", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1),
        SizedBox(height: 5,),
        AppTextField(labelText: "Enter Mobile Number",),
        SizedBox(height: 5,),
        AppTextField(labelText: "Enter Email Address",),
        SizedBox(height: 5,),
        AppText(text: "Shipping Address",),
        SizedBox(height: 5,),
        Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: typeList.map((type) {
              return Row(
                children: [
                  Radio<String>(
                    value: type,
                    groupValue: selectedType,
                    onChanged: (value) {

                    },
                  ),
                  AppText(text: type),
                  const SizedBox(width: 10),
                ],
              );
            }).toList(),
          )

        ],),
        SizedBox(height: 5,),
        AppTextField(labelText: "Complete shipping address",),
        SizedBox(height: 10,),
        AppButton(text: "Add Transport Info",color: Color(0xFF8EBF1F),)
      ],),
    ),);
  }
}
