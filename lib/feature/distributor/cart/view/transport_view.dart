import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

import '../../../../widget/app_button.dart';


class TransportView extends StatelessWidget {
   TransportView({super.key});

  final List<String> typeList=["Full Container","Part Loader"];
  String selectedType="Full Container";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyStepper(
            activeStep: 2,
            lineStyle: LineStyle(
              lineType: LineType.normal,
              lineThickness: 2,
              defaultLineColor: Colors.grey.shade300,
              finishedLineColor: Colors.green,
            ),
            stepRadius: 14,
            activeStepBorderColor: Color(0xFF8EBF1F),
            activeStepIconColor: Colors.white,
            activeStepBackgroundColor: Color(0xFF8EBF1F),
            activeStepTextColor: Color(0xFF8EBF1F),
            finishedStepBackgroundColor: Color(0xFF8EBF1F),
            finishedStepIconColor: Colors.white,
            finishedStepTextColor: Color(0xFF8EBF1F),
            unreachedStepBorderColor: Colors.grey,
            unreachedStepIconColor: Colors.grey,
            unreachedStepBackgroundColor: Colors.white,
            showLoadingAnimation: false,
            steps: const [
              EasyStep(
                icon: Icon(Icons.check),
                title: 'Products',
              ),
              EasyStep(
                icon: Icon(Icons.check),
                title: 'Dealer Info',
              ),
              EasyStep(
                icon: Icon(Icons.circle),
                title: 'Transport',
              ),
              EasyStep(
                icon: Icon(Icons.circle_outlined),
                title: 'Review',
              ),
            ],
          ),
        AppText(text: "Type",fontWeight: FontWeight.w700,),
        Row(
          children: typeList.map((type) {
            return Row(
              children: [
                Radio<String>(
                  value: type,
                  groupValue: selectedType,
                  onChanged: (value) {
                  },
                ),
                Text(type),
                const SizedBox(width: 12),
              ],
            );
          }).toList(),
        ),
        AppTextField(labelText: "Remarks",),
        SizedBox(height: 10,),
        AppButton(text: "Add New Address", isLoading: false, onPressed: (){},color: Color(0xFF0067B1),),
        SizedBox(height: 5,),
        Expanded(
          child: ListView.separated(itemBuilder: (context, index) {
            return Card(child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF8EBF1F),),
                        child: Icon(Icons.check,color: Colors.white,)),
                    SizedBox(width: 20,),
                    AppText(text: "Billing Address"),
                  ],),
                  Divider(),
                  SizedBox(height: 5,),
                  AppText(text: "Silicon India Private Limited"),
                  AppText(text: "Ramesh Patel"),
                  AppText(text: "GST: 24AAACH7409R2Z6"),
                  AppText(text: "Maharashtra"),
                  AppText(text: "+91 1234567890"),
                  AppText(text: "info@sillicon.com"),
                  AppText(text: "Shipping Address: Same as Billing Address")
                ],),
            ),);
          }, separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: 4),
        ),
        SizedBox(height: 8,),
        AppButton(text: "Add Dealer Info", isLoading: false, onPressed: () {},color: Color(0xFF8EBF1F),),
        SizedBox(height: 10,)
      ],),
    ),);
  }
}
