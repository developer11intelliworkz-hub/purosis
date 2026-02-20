import 'package:flutter/material.dart';

class CustomHorizontalStepper extends StatelessWidget {
  final List<StepItem> steps;

  const CustomHorizontalStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  _buildCircle(step),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: step.isCompleted
                            ? Colors.green
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                step.title,
                style: TextStyle(
                  fontSize: 12,
                  color: step.isActive || step.isCompleted
                      ? Colors.green
                      : Colors.grey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCircle(StepItem step) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: step.isCompleted || step.isActive
            ? Colors.green
            : Colors.white,
        border: Border.all(
          color: step.isCompleted || step.isActive
              ? Colors.green
              : Colors.grey,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: step.isCompleted
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}


class StepItem {
  final String title;
  final bool isCompleted;
  final bool isActive;

  StepItem({
    required this.title,
    this.isCompleted = false,
    this.isActive = false,
  });
}
