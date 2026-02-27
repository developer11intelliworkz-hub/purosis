import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final VoidCallback? onPressed;
  final double height;
  final double radius;
  final Color color;

  const AppButton({
    super.key,
    required this.text,
    this.isLoading,
    this.onPressed,
    this.height = 48,
    this.radius = 8,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isLoading ?? false) ? null : onPressed,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: (isLoading ?? false)
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
