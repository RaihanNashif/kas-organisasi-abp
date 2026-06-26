import 'package:flutter/material.dart';

class LaporanContent extends StatelessWidget {
  const LaporanContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Halaman Laporan",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}