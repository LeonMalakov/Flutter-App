import 'package:flutter/cupertino.dart';

class BoardingScreenItem extends StatelessWidget {
  final String description;

  const BoardingScreenItem({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(
            height: 480,
          ),
          Text(description, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}