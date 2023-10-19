import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: const TextStyle(fontFamily: 'OpenSans'),
        ),
      ],
    );
  }
}
