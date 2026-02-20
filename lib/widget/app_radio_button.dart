import 'package:flutter/material.dart';

class AppRadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function(String) onChanged;

  const AppRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
