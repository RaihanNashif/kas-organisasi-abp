import 'package:flutter/material.dart';
import '../../services/ai_service.dart';
import 'package:intl/intl.dart';

class AIContent extends StatefulWidget {
  const AIContent({super.key});

  @override
  State<AIContent> createState() => _AIContentState();
}

class _AIContentState extends State<AIContent> {
  
  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Color getStatusColor(String status) {
    switch (status) {
        case "Sangat Sehat":
        return Colors.green;

        case "Sehat":
        return Colors.blue;

        case "Waspada":
        return Colors.orange;

        case "Defisit":
        return Colors.red;

        default:
        return Colors.grey;
    }
  }

  Map<String, dynamic>? data;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAI();
  }

  Future<void> loadAI() async {
    final result = await AIService.getAnalisis();

    setState(() {
      data = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),

      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "🤖 AI Financial Assistant",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                            Row(
                                children: [

                                    Icon(
                                        Icons.smart_toy,
                                        color: getStatusColor(data!["status"]),
                                        size: 35,
                                    ),

                                    const SizedBox(width: 10),

                                    Text(
                                        data!["status"],
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: getStatusColor(data!["status"]),
                                        ),
                                    ),

                                ],
                            ),

                            const SizedBox(height: 20),

                            Text(
                                "AI Score : ${data!["score"]}/100",
                                style: const TextStyle(
                                    fontSize: 18,
                                ),
                            ),

                            const SizedBox(height: 10),

                            LinearProgressIndicator(
                                value: data!["score"] / 100,
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(20),
                            ),

                        ],
                    ),
                ),
            ),

            const SizedBox(height: 25),

            Card(
                child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(

                        children: [

                            ListTile(
                                leading: const Icon(Icons.attach_money,color: Colors.green),
                                title: const Text("Total Pemasukan"),
                                trailing: Text(
                                    rupiah.format(
                                    double.parse(
                                        data!["total_pemasukan"].toString(),
                                    ),
                                    ),
                                ),
                            ),

                            ListTile(
                                leading: const Icon(Icons.money_off,color: Colors.red),
                                title: const Text("Total Pengeluaran"),
                                trailing: Text(
                                    rupiah.format(
                                    double.parse(
                                        data!["total_pengeluaran"].toString(),
                                    ),
                                    ),
                                ),
                            ),

                            ListTile(
                                leading: const Icon(Icons.account_balance_wallet,color: Colors.blue),
                                title: const Text("Saldo"),
                                trailing: Text(
                                    rupiah.format(
                                    double.parse(
                                        data!["saldo"].toString(),
                                    ),
                                    ),
                                ),
                            ),

                            ListTile(
                                leading: const Icon(Icons.percent,color: Colors.orange),
                                title: const Text("Rasio Pengeluaran"),
                                trailing: Text(
                                    "${data!["rasio"]} %",
                                ),
                            ),

                        ],
                    ),
                ),
            ),

            const SizedBox(height: 25),

            const Text(
                "Analisis",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                ),
            ),

            ...data!["analisis"].map<Widget>((e) {

                return ListTile(

                    leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                    ),

                    title: Text(e),

                );

            }).toList(),

            const SizedBox(height: 20),

            const Text(
                "Rekomendasi",
              style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                ),
            ),

            ...data!["rekomendasi"].map<Widget>((e) {

                return ListTile(

                    leading: const Icon(
                        Icons.lightbulb,
                        color: Colors.orange,
                    ),

                    title: Text(e),

                );

            }).toList(),

          ],

        ),

      ),

    );
  }
}