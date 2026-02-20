import 'package:flutter/material.dart';
import 'package:purosis/feature/admin/stock/view/widget/items_list.dart';
import 'package:purosis/feature/admin/stock/view/widget/transaction_history_list.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class PromotionalStock extends StatelessWidget {
  const PromotionalStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Promotional Stock"),body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(children: [
        Expanded(child: AppButton(text: "Inward",color: Color(0xFF8EBF1F),)),
        SizedBox(width: 10,),
        Expanded(child: AppButton(text: "Outward",color: Color(0xFF0067B1),))
      ],),
      SizedBox(height: 10,),
      Row(children: [
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: AppText(text: "Items",fontWeight: FontWeight.w600,),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: AppText(text: "Transactions History",fontWeight: FontWeight.w600,),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),),
        ),
      ],),
      SizedBox(height: 10,),
        Expanded(child: TransactionHistoryList())

    ],),);
  }
}
