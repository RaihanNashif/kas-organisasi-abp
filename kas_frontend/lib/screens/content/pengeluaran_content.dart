import 'package:flutter/material.dart';

class PengeluaranContent extends StatelessWidget {
  const PengeluaranContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Halaman Pengeluaran",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}