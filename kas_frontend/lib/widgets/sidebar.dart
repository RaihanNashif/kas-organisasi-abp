import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuTap;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final menus = [
      {
        "title": "Dashboard",
        "icon": Icons.dashboard,
      },
      {
        "title": "Pemasukan",
        "icon": Icons.attach_money,
      },
      {
        "title": "Pengeluaran",
        "icon": Icons.money_off,
      },
      {
        "title": "Laporan",
        "icon": Icons.description,
      },
    ];

    return Container(
      width: 250,
      color: const Color(0xFF27AE60),
      child: Column(
        children: [
          const SizedBox(height: 30),

          const Text(
            "Kas RT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final active = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor:
                        active ? const Color(0xFF2EE84A) : Colors.transparent,
                    leading: Icon(
                      menus[index]["icon"] as IconData,
                      color: Colors.white,
                    ),
                    title: Text(
                      menus[index]["title"] as String,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => onMenuTap(index),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          )
        ],
      ),
    );
  }
}