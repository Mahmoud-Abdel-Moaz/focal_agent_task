
import 'package:flutter/material.dart';
import 'package:focal_agent_task/core/sizes/ui_sizes.dart';
import 'package:focal_agent_task/features/employees/presentation/widgets/user_avatar.dart';

import '../../domain/entities/employee.dart';
import '../../domain/enums/employee_category.dart';
import 'category_badge.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isIT = employee.category == EmployeeCategory.iT;

    final containerColor =
    isIT ? cs.primaryContainer : cs.secondaryContainer;
    final onContainerColor =
    isIT ? cs.onPrimaryContainer : cs.onSecondaryContainer;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UISizes.employeeCardBorderRadius),
        border: Border.all(
          color: cs.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: UISizes.employeeCardHorizontalPadding,vertical: UISizes.employeeCardVerticalPadding),
        child: Row(
          children: [
            UserAvatar(
              initial: employee.firstName[0],
              bg: containerColor,
              fg: onContainerColor,
            ),
             SizedBox(width: UISizes.employeeCardUserAvatarSpace),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${employee.firstName} ${employee.lastName}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   SizedBox(height: UISizes.employeeCardNameSpace),
                  Text(
                    'ID: ${employee.employeeId}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.outline,
                    ),
                  ),
                ],
              ),
            ),
            CategoryBadge(
              label: employee.category.text,
              bg: containerColor,
              fg: onContainerColor,
            ),
          ],
        ),
      ),
    );
  }
}