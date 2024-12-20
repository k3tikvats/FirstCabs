import 'package:flutter/material.dart';

class DestinationItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const DestinationItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ],
    );
  }
}