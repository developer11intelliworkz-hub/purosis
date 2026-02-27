import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.icon,
    required this.count,
    required this.bottomText,
  });
  final String icon;
  final String count;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFDEF1FF),
              ),
              child: Image.asset(icon),
            ),
            SizedBox(height: 15),
            AppText(text: count, fontSize: 25, fontWeight: FontWeight.w700),
            SizedBox(height: 8),
            AppText(
              text: bottomText,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
