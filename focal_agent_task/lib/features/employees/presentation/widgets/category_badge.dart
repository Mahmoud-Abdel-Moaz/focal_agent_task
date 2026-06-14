import 'package:flutter/material.dart';

import '../../../../core/sizes/ui_sizes.dart';

class CategoryBadge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;

  const CategoryBadge({super.key,
    required this.label,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: UISizes.categoryBadgeHorizontalPadding, vertical: UISizes.categoryBadgeVerticalPadding),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: UISizes.categoryBadgeTextSize,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}