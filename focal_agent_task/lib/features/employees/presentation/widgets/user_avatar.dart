
import 'package:flutter/material.dart';
import 'package:focal_agent_task/core/sizes/ui_sizes.dart';

class UserAvatar extends StatelessWidget {
  final String initial;
  final Color bg;
  final Color fg;

  const UserAvatar({super.key,
    required this.initial,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: UISizes.userAvatarSize,
      backgroundColor: bg,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: UISizes.userAvatarTextSize,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}