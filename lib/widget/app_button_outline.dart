import 'package:flutter/material.dart';

class AppButtonOutline extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final VoidCallback? onPressed;
  final double height;
  final double radius;
  final Color color;
  final Widget? prefixIcon;

  const AppButtonOutline({
    super.key,
    required this.text,
    this.isLoading,
    this.onPressed,
    this.height = 48,
    this.radius = 8,
    this.color = Colors.blue,
    this.prefixIcon,
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: color, width: 1.5),
        ),
        child: (isLoading ?? false)
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(color: color),
                      child: prefixIcon!,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
