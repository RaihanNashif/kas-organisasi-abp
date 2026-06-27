import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final Widget? action;

  const PageHeader({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (action != null) action!,

        ],
      ),
    );
  }
}