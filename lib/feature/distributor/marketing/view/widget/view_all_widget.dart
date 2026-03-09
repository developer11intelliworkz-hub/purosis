import 'package:flutter/material.dart';

import '../../../../../widget/app_text.dart';

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AppText(text: "View All", color: Color(0xFF8EBF1F)),
          Icon(Icons.arrow_right_alt, color: Color(0xFF8EBF1F)),
        ],
      ),
    );
  }
}
