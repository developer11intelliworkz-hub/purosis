import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_radio_button.dart';

class UserActivityLocation extends StatefulWidget {
  const UserActivityLocation({super.key});

  @override
  State<UserActivityLocation> createState() => _UserActivityLocationState();
}

class _UserActivityLocationState extends State<UserActivityLocation> {
  List<String> radioList = ["App Open", "Orders", "Both"];

  String selectValue = "Both";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "company Name"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText(text: "Today"),
                ),
                SizedBox(width: 5),
                Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText(text: "7 Days"),
                ),
                SizedBox(width: 5),
                Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText(text: "30 Days"),
                ),
                SizedBox(width: 5),
                Container(
                  height: 40,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText(text: "Custom"),
                ),
              ],
            ),
          ),
          Row(
            children: radioList
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppRadioButton(
                      value: e,
                      groupValue: selectValue,
                      onChanged: (value) {},
                    ),
                  ),
                )
                .toList(),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Order Placed",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                AppText(text: "Mumbai,India", fontSize: 10),
                Divider(),
                AppText(text: "Order Value: ₹42 500"),
                AppText(text: "Date: 10 Jan 2026"),
                AppText(text: "Time: 11:11 AM"),
                AppText(text: "Device: Android Tablet"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
