import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Column(children: [
      EasyStepper(
        activeStep: 0,
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
            icon: Icon(Icons.circle),
            title: 'Products',
          ),
          EasyStep(
            icon: Icon(Icons.circle_outlined),
            title: 'Dealer Info',
          ),
          EasyStep(
            icon: Icon(Icons.circle_outlined),
            title: 'Transport',
          ),
          EasyStep(
            icon: Icon(Icons.circle_outlined),
            title: 'Review',
          ),
        ],
      ),
      Expanded(
        child: ListView.separated(itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 130,),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(text: "PuroAqua Water Purifiers",fontWeight: FontWeight.w700,),
                          AppText(text: "Color: Matt Black",fontWeight: FontWeight.w400,),
                          SizedBox(height: 10,),
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(8)),
                            child: Row(children: [
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                    color: Color(0xFFCAE6FB),),
                                  child: Icon(Icons.remove),),
                              ),
                              Expanded(child: AppText(text: "3",align: TextAlign.center,)),
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                    color: Color(0xFFCAE6FB),),
                                  child: Icon(Icons.add),),
                              )
                            ],),),
                          SizedBox(height: 3,),
                          AppText(text: "20 units in 1 Box")
                        ],),
                    ),
                    Icon(Icons.close)
                  ],),
              ),);
        },itemCount: 3, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 5,),),
      ),
      Container(
        padding: EdgeInsets.only(right: 8,left: 8),
        child: Column(children: [
        Row(children: [
          AppText(text: "Total Weight: 25.50KG"),
          Spacer(),
          AppText(text: "Total CBM: 0.1200 m3")
        ],),
        SizedBox(height: 8,),
        AppButton(text: "Add Dealer Info", isLoading: false, onPressed: () {},color: Color(0xFF8EBF1F),),
        SizedBox(height: 10,)
      ],),)
    ],),);
  }
}
