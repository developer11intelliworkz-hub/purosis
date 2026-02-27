import 'package:flutter/material.dart';

import '../../../../../widget/app_text.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Transaction History",
          color: Color(0xFF0067B1),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(flex: 2, child: AppText(text: "Serial No.")),
            Expanded(flex: 3, child: AppText(text: "Type")),
            Expanded(flex: 2, child: AppText(text: "Items")),
            Expanded(flex: 2, child: AppText(text: "Quantity")),
            Expanded(flex: 2, child: AppText(text: "Recipient")),
          ],
        ),
        Divider(color: Color(0xFF8EBF1F)),
        SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: AppText(text: "PROMO-001")),
                  SizedBox(width: 2),
                  Expanded(
                    flex: 3,
                    child: Wrap(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF0067B1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_circle_up_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              AppText(text: "Outward", color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(flex: 2, child: AppText(text: "Unknown")),
                  SizedBox(width: 2),
                  Expanded(flex: 2, child: AppText(text: "500")),
                  SizedBox(width: 2),
                  Expanded(
                    flex: 2,
                    child: AppText(text: "Mumbai Water Solutions"),
                  ),
                ],
              );
            },
            itemCount: 4,
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ),
      ],
    );
  }
}
