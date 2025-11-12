import 'package:flutter/material.dart';

class FeeCard extends StatelessWidget {
  final String title;
  final String amount;
  final bool isDue;
  final VoidCallback onTap;

  const FeeCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isDue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDue ? Colors.orange : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDue ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text("₹ $amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDue ? Colors.white : Colors.black)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
