import 'package:flutter/material.dart';

class AppBadgeWidget extends StatelessWidget {
  final Widget child;
  final bool showBadge;

  const AppBadgeWidget({
    super.key,
    required this.child,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,

        if (showBadge)
          const Positioned(
            right: -2,
            top: -2,
            child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
          ),
      ],
    );
  }
}
