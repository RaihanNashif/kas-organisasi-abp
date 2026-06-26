import 'package:flutter/material.dart';

import '../../services/dashboard_service.dart';
import '../../widgets/dashboard_card.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() =>
      _DashboardContentState();
}

class _DashboardContentState
    extends State<DashboardContent> {

  Map<String, dynamic>? dashboardData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      final result =
          await DashboardService.getDashboard();

      setState(() {
        dashboardData = result;
        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          GridView.count(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisCount:
                MediaQuery.of(context).size.width > 900
                    ? 2
                    : 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2.5,
            children: [

              DashboardCard(
                title: "Total Pemasukan",
                value:
                    "Rp ${dashboardData?['total_pemasukan'] ?? 0}",
                icon: Icons.attach_money,
              ),

              DashboardCard(
                title: "Total Pengeluaran",
                value:
                    "Rp ${dashboardData?['total_pengeluaran'] ?? 0}",
                icon: Icons.money_off,
              ),

              DashboardCard(
                title: "Saldo",
                value:
                    "Rp ${dashboardData?['saldo'] ?? 0}",
                icon:
                    Icons.account_balance_wallet,
              ),

              DashboardCard(
                title: "Jumlah Laporan",
                value:
                    "${dashboardData?['jumlah_laporan'] ?? 0}",
                icon: Icons.description,
              ),
            ],
          ),
        ],
      ),
    );
  }
}