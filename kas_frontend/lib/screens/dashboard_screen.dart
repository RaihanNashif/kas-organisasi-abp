import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'content/dashboard_content.dart';
import 'content/pemasukan_content.dart';
import 'content/pengeluaran_content.dart';
import 'content/laporan_content.dart';
import 'content/ai_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  int selectedMenu = 0;

  Widget getContent() {

    switch (selectedMenu) {

      case 1:
        return const PemasukanContent();

      case 2:
        return const PengeluaranContent();

      case 3:
        return const LaporanContent();

      case 4:
        return const AIContent();

      default:
        return const DashboardContent();
    }
  }

  @override
  Widget build(BuildContext context) {

    final isDesktop =
        MediaQuery.of(context).size.width > 900;

    return Scaffold(
      drawer: !isDesktop
          ? Drawer(
              child: Sidebar(
                selectedIndex: selectedMenu,
                onMenuTap: (index) {
                  setState(() {
                    selectedMenu = index;
                  });
                },
              ),
            )
          : null,

      appBar: !isDesktop
          ? AppBar(
              title: const Text("Kas RT"),
            )
          : null,

      body: Row(
        children: [

          if (isDesktop)
            Sidebar(
              selectedIndex: selectedMenu,
              onMenuTap: (index) {
                setState(() {
                  selectedMenu = index;
                });
              },
            ),

          Expanded(
            child: Container(
              color: const Color(0xFFF4F4F4),
              child: getContent(),
            ),
          ),
        ],
      ),
    );
  }
}