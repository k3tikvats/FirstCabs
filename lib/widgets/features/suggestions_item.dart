import 'package:flutter/material.dart';

class SuggestionTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isComingSoon;

  const SuggestionTile({
    Key? key,
    required this.imagePath,
    required this.title,
    this.isComingSoon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          // If it's coming soon, show a placeholder container
          if (isComingSoon)
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Coming Soon",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          else
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}