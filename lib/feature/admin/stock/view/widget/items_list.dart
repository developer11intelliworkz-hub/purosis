import 'package:flutter/material.dart';

import '../../../../../widget/app_text.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Promotional Items",
          color: Color(0xFF0067B1),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(flex: 2, child: AppText(text: "Serial No.")),
            Expanded(flex: 2, child: AppText(text: "Name")),
            Expanded(flex: 2, child: AppText(text: "Description")),
            Expanded(flex: 1, child: AppText(text: "Stock")),
            AppText(text: "Actions"),
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
                  Expanded(flex: 2, child: AppText(text: "Branded Carry Bags")),
                  SizedBox(width: 2),
                  Expanded(
                    flex: 2,
                    child: AppText(
                      text: "High quality carry bags with Purosis branding",
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    flex: 1,
                    child: Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF0067B1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AppText(text: "500", color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2),
                  Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.grey),
                      SizedBox(width: 5),
                      Icon(Icons.edit_outlined, color: Colors.grey),
                    ],
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
